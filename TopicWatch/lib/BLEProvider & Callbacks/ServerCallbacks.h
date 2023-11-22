#ifndef SERVERCALLBACKS_H
#define SERVERCALLBACKS_H

#include <NimBLEDevice.h>
#include <ArduinoJson.h>
#include "BLEProvider.h"

class ServerCallbacks : public NimBLEServerCallbacks
{
    public:
        ServerCallbacks() = default;
    private:
        void sendTimeRequest(NimBLECharacteristic* characteristic);
        void onConnect(NimBLEServer *pServer, ble_gap_conn_desc *desc);
        void onDisconnect(NimBLEServer* pServer);
};
#endif