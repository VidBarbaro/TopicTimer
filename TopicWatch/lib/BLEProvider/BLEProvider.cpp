#include "BLEProvider.h"

NimBLEServer *BLEProvider::_pTopicWatchServer = nullptr;
NimBLEService *_pTopicWatchService = nullptr;
NimBLECharacteristic *_pTopicWatchCharacteristic = nullptr;

OnConnectedCallback BLEProvider::_onConnectedCallback = nullptr;
OnDisconnectedCallback BLEProvider::_onDisconnectCallback = nullptr;
OnReadCallback BLEProvider::_onReadCallback = nullptr;
OnWriteCallback BLEProvider::_onWriteCallback = nullptr;

BLEProvider::BLEProvider(OnConnectedCallback connectCallback, OnDisconnectedCallback disconnectCallback, OnReadCallback readCallback, OnWriteCallback writeCallback)
{
    /*
     * Set callbacks
     */
    _onConnectedCallback = connectCallback;
    _onDisconnectCallback = disconnectCallback;
    _onReadCallback = readCallback;
    _onWriteCallback = writeCallback;

    /*
     * Create BLE server
     */
    NimBLEDevice::init("TopicWatch");

    //     /** Optional: set the transmit power, default is 3db */
    // #ifdef ESP_PLATFORM
    //     NimBLEDevice::setPower(ESP_PWR_LVL_P9); /** +9db */
    // #else
    //     NimBLEDevice::setPower(9); /** +9db */
    // #endif
    //     NimBLEDevice::setSecurityAuth(false, false, false);

    //     _pTopicWatchServer = NimBLEDevice::createServer();
    //     _pTopicWatchServer->setCallbacks(new ServerCallbacks());

    //     _pTopicWatchService = _pTopicWatchServer->createService(BLE_UUID_SERVICE);
    //     _pTopicWatchCharacteristic = _pTopicWatchService->createCharacteristic(
    //         BLE_UUID_CHARACTERISTIC,
    //         NIMBLE_PROPERTY::READ |
    //             NIMBLE_PROPERTY::WRITE |
    //             NIMBLE_PROPERTY::NOTIFY);
    //     _pTopicWatchCharacteristic->setCallbacks(new CharacteristicCallbacks());

    //     /** Start the services when finished creating all Characteristics and Descriptors */
    //     _pTopicWatchService->start();

    //     NimBLEAdvertising *pAdvertising = NimBLEDevice::getAdvertising();
    //     /** Add the services to the advertisment data **/
    //     pAdvertising->addServiceUUID(_pTopicWatchService->getUUID());
    //     /** If your device is battery powered you may consider setting scan response
    //      *  to false as it will extend battery life at the expense of less data sent.
    //      */
    //     pAdvertising->setScanResponse(true);
    //     pAdvertising->start();
}

void BLEProvider::write(String value)
{
    _pTopicWatchCharacteristic->setValue(value);
    _pTopicWatchCharacteristic->notify();
}