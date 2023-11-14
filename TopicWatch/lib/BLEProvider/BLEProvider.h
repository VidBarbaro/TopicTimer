#ifndef BLE_PROVIDER
#define BLE_PROVIDER

#include "BLEConfig.h"
#include <NimBLEDevice.h>

class BLEProvider
{
private:
    NimBLEServer *_pServer;

    class ServerCallbacks : public NimBLEServerCallbacks
    {

        void onConnect(NimBLEServer *pServer, ble_gap_conn_desc *desc)
        {
            Serial.print("Client address: ");
            Serial.println(NimBLEAddress(desc->peer_ota_addr).toString().c_str());

            pServer->updateConnParams(desc->conn_handle, 24, 48, 0, 60);
        };
        void onDisconnect(NimBLEServer *pServer)
        {
            Serial.println("Client disconnected - start advertising");
            NimBLEDevice::startAdvertising();
        };
    };

    class CharacteristicCallbacks : public NimBLECharacteristicCallbacks
    {
        void onRead(NimBLECharacteristic *pCharacteristic)
        {
            Serial.print(pCharacteristic->getUUID().toString().c_str());
            Serial.print(": onRead(), value: ");
            Serial.println(pCharacteristic->getValue().c_str());
        };

        void onWrite(NimBLECharacteristic *pCharacteristic)
        {
            Serial.print(pCharacteristic->getUUID().toString().c_str());
            Serial.print(": onWrite(), value: ");
            Serial.println(pCharacteristic->getValue().c_str());
        };
    };

    CharacteristicCallbacks _chrCallbacks;

public:
    BLEProvider() = default;
    ~BLEProvider() = default;
    void init();
};

#endif