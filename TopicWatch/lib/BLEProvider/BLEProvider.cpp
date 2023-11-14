#include "BLEProvider.h"

void BLEProvider::init()
{
    /** sets device name */
    NimBLEDevice::init(BLE_DEVICE_NAME);

#ifdef ESP_PLATFORM
    NimBLEDevice::setPower(ESP_PWR_LVL_P9); /** +9db */
#else
    NimBLEDevice::setPower(9); /** +9db */
#endif

    NimBLEDevice::setSecurityAuth(false, false, false);

    _pServer = NimBLEDevice::createServer();
    _pServer->setCallbacks(new ServerCallbacks);

    NimBLEService *pService = _pServer->createService("a6846862-7efa-11ee-b962-0242ac120002");
    NimBLECharacteristic *pCharacteristic = pService->createCharacteristic("a6846b78-7efa-11ee-b962-0242ac120002", NIMBLE_PROPERTY::READ | NIMBLE_PROPERTY::WRITE | NIMBLE_PROPERTY::NOTIFY);
    pCharacteristic->setCallbacks(&_chrCallbacks);

    pService->start();

    NimBLEAdvertising *pAdvertising = NimBLEDevice::getAdvertising();
    pAdvertising->addServiceUUID(pService->getUUID());

    pAdvertising->setScanResponse(true);
    pAdvertising->start();
}