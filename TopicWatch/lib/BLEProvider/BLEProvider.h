#ifndef BLE_PROVIDER
#define BLE_PROVIDER

#include "Arduino.h"
#include "BLEConfig.h"
#include "NimBLEDevice.h"

typedef void (*OnConnectedCallback)();
typedef void (*OnDisconnectedCallback)();
typedef void (*OnReadCallback)(const char *);
typedef void (*OnWriteCallback)(const char *);

class BLEProvider
{
private:
    class ServerCallbacks : public NimBLEServerCallbacks
    {
        void onConnect(NimBLEServer *pServer, ble_gap_conn_desc *desc)
        {
            NimBLEDevice::stopAdvertising();
        };

        void onDisconnect(NimBLEServer *pServer){
            // NimBLEDevice::startAdvertising(); // nothing for now
        };
    };

    /** Handler class for characteristic actions */
    class CharacteristicCallbacks : public NimBLECharacteristicCallbacks
    {
        void onRead(NimBLECharacteristic *pCharacteristic)
        {
            if (BLEProvider::_onReadCallback != nullptr)
            {
                BLEProvider::_onReadCallback(pCharacteristic->getValue().c_str());
            }
        };

        void onWrite(NimBLECharacteristic *pCharacteristic)
        {
            if (BLEProvider::_onWriteCallback != nullptr)
            {
                BLEProvider::_onWriteCallback(pCharacteristic->getValue().c_str());
            }
        };
    };

    static NimBLEServer *_pTopicWatchServer;
    static NimBLEService *_pTopicWatchService;
    static NimBLECharacteristic *_pTopicWatchCharacteristic;

    static OnConnectedCallback _onConnectedCallback;
    static OnDisconnectedCallback _onDisconnectCallback;
    static OnReadCallback _onReadCallback;
    static OnWriteCallback _onWriteCallback;

public:
    BLEProvider(OnConnectedCallback connectCallback, OnDisconnectedCallback disconnectCallback, OnReadCallback readCallback, OnWriteCallback writeCallback);
    ~BLEProvider() = default;
    void write(String value);
};

#endif