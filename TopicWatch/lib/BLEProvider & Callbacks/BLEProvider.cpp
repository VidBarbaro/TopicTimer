#include "BLEProvider.h"

static long currentTime = 0;
static long pastTime = 0;
const long interval = 3000;

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
    if (trackedTimesBuffer.getCount() == 0)
    {
        return;
    }
    StaticJsonDocument<512> doc;
    TrackingInfo *newInfo = trackedTimesBuffer.consume();

    if (newInfo == nullptr)
    {
        // Something went wrong gathering the tracked times...
        return;
    }

    doc["command"] = "setTrackedTime";
    doc["data"]["topic"]["id"] = newInfo->topicId;
    doc["data"]["beginTime"]["time"]["hours"] = newInfo->startTime.hours;
    doc["data"]["beginTime"]["time"]["minutes"] = newInfo->startTime.minutes;
    doc["data"]["beginTime"]["time"]["seconds"] = newInfo->startTime.seconds;
    doc["data"]["beginTime"]["date"]["year"] = newInfo->startTime.year;
    doc["data"]["beginTime"]["date"]["month"] = newInfo->startTime.month;
    doc["data"]["beginTime"]["date"]["day"] = newInfo->startTime.day;

    doc["data"]["endTime"]["time"]["hours"] = newInfo->endTime.hours;
    doc["data"]["endTime"]["time"]["minutes"] = newInfo->endTime.minutes;
    doc["data"]["endTime"]["time"]["seconds"] = newInfo->endTime.seconds;
    doc["data"]["endTime"]["date"]["year"] = newInfo->endTime.year;
    doc["data"]["endTime"]["date"]["month"] = newInfo->endTime.month;
    doc["data"]["endTime"]["date"]["day"] = newInfo->endTime.day;

    String message = " ";
    serializeJson(doc, message);
    Serial.println(message);
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

void BLEProvider::update()
{
    if (trackedTimesBuffer.getCount() > 0 && _connectionState)
    {
        Serial.println("Trying to consume new tracked times message");
        sendTrackedTimes();
    }
}