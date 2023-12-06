#include "BLEProvider.h"

void BLEProvider::init()
{
    _instance = this;

    /** sets device name */
    NimBLEDevice::init(BLE_DEVICE_NAME);

#ifdef ESP_PLATFORM
    NimBLEDevice::setPower(ESP_PWR_LVL_P9); /** +9db */
#else
    NimBLEDevice::setPower(9); /** +9db */
#endif

    NimBLEDevice::setSecurityAuth(false, false, false);

    _pServer = NimBLEDevice::createServer();

    _pServiceTime = _pServer->createService(BLE_UUID_SERVICE_TIME);
    _pServiceTopic = _pServer->createService(BLE_UUID_SERVICE_TOPIC);
    _pCharacteristicTime = _pServiceTime->createCharacteristic(BLE_UUID_CHARACTERISTIC_TIME, NIMBLE_PROPERTY::READ | NIMBLE_PROPERTY::WRITE | NIMBLE_PROPERTY::NOTIFY);
    _pCharacteristicTopic = _pServiceTopic->createCharacteristic(BLE_UUID_CHARACTERISTIC_TOPIC, NIMBLE_PROPERTY::READ | NIMBLE_PROPERTY::WRITE | NIMBLE_PROPERTY::NOTIFY);
    _pCharacteristicTime->setCallbacks(new CharacteristicCallbacks(_instance));
    _pCharacteristicTopic->setCallbacks(new CharacteristicCallbacks(_instance));

    _pServer->setCallbacks(new ServerCallbacks(_instance));

    _pServiceTime->start();
    _pServiceTopic->start();

    NimBLEAdvertising *pAdvertising = NimBLEDevice::getAdvertising();
    pAdvertising->addServiceUUID(_pServiceTime->getUUID());
    pAdvertising->addServiceUUID(_pServiceTopic->getUUID());

    pAdvertising->setScanResponse(true);
    pAdvertising->start();
}

void BLEProvider::sendTimeRequest(void)
{
    StaticJsonDocument<128> doc;

    doc["command"] = "getTime";
    String message = " ";
    serializeJson(doc, message);
    write(message, _pCharacteristicTime);
}

void BLEProvider::sendTopicsRequest(void)
{
    StaticJsonDocument<128> doc;

    doc["command"] = "getTopics";
    String message = " ";
    serializeJson(doc, message);
    write(message, _pCharacteristicTopic);
}

void BLEProvider::sendTrackedTimes(void)
{
    StaticJsonDocument<300> doc;
    // Dummy data
    doc["command"] = "setTrackedTime";
    doc["data"]["topic"]["id"] = 1;
    doc["data"]["beginTime"]["time"]["hours"] = 11;
    doc["data"]["beginTime"]["time"]["minutes"] = 22;
    doc["data"]["beginTime"]["time"]["seconds"] = 33;
    doc["data"]["beginTime"]["date"]["year"] = 2023;
    doc["data"]["beginTime"]["date"]["month"] = 06;
    doc["data"]["beginTime"]["date"]["day"] = 03;

    doc["data"]["endTime"]["time"]["hours"] = 12;
    doc["data"]["endTime"]["time"]["minutes"] = 44;
    doc["data"]["endTime"]["time"]["seconds"] = 55;
    doc["data"]["endTime"]["date"]["year"] = 2023;
    doc["data"]["endTime"]["date"]["month"] = 06;
    doc["data"]["endTime"]["date"]["day"] = 03;

    String message = " ";
    serializeJson(doc, message);
    write(message, _pCharacteristicTopic);
}

/// @brief
/// @param value
/// @return TRUE if succesfull OR FALSE for failure
bool BLEProvider::write(String value, NimBLECharacteristic *characteristic)
{
    if (value == NULL)
    {
        Serial.println("[ERROR]: in function: BLEProvider::write param is NULL");
        return false;
    }

    if (characteristic == NULL)
    {
        Serial.println("[ERROR]: Characteristic is NULL");
        return false;
    }
    Serial.print("[SENDING]: ");
    Serial.println(value);

    characteristic->setValue(value);
    characteristic->indicate();
    return true;
}

void BLEProvider::setConnectionState(bool newState)
{
    if (newState != _connectionState)
    {
        _stateChanged = true;
        _connectionState = newState;
    }
}

int BLEProvider::getConnectionState()
{
    int returnValue = _stateChanged ? _connectionState : -1;
    _stateChanged = false;
    return returnValue;
}