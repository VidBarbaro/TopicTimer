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
    _pServer->setCallbacks(new ServerCallbacks(_instance));

    NimBLEService *pService = _pServer->createService("a6846862-7efa-11ee-b962-0242ac120002");
    NimBLECharacteristic *_pCharacteristic = pService->createCharacteristic("a6846b78-7efa-11ee-b962-0242ac120002", NIMBLE_PROPERTY::READ | NIMBLE_PROPERTY::WRITE | NIMBLE_PROPERTY::NOTIFY);
    _pCharacteristic->setCallbacks(new CharacteristicCallbacks(_instance));

    pService->start();

    NimBLEAdvertising *pAdvertising = NimBLEDevice::getAdvertising();
    pAdvertising->addServiceUUID(pService->getUUID());

    pAdvertising->setScanResponse(true);
    pAdvertising->start();
}

void BLEProvider::sendTimeRequest(void)
{
    StaticJsonDocument<100> doc;

    doc["command"] = "getTime";
    String message = " ";   
    serializeJson(doc, message);
    write(message);
}

void BLEProvider::sendTopicsRequest(void)
{
    StaticJsonDocument<100> doc;

    doc["command"] = "getTopics";
    String message = " ";   
    serializeJson(doc, message);
    write(message);
}

void BLEProvider::sendTrackedTimes(void)
{
    StaticJsonDocument<300> doc;
    //Dummy data
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
    write(message);
}

/// @brief 
/// @param value 
/// @return TRUE if succesfull OR FALSE for failure  
bool BLEProvider::write(String value)
{
    if(value == NULL)
    {
        return false;
    }

    if(_pCharacteristic == NULL)
    {
        return false;
    }
    _pCharacteristic->setValue(value);
    _pCharacteristic->notify();
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