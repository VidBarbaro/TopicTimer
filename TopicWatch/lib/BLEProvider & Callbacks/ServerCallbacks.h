#ifndef SERVERCALLBACKS_H
#define SERVERCALLBACKS_H

#include "BLEProvider.h"
#include <NimBLEDevice.h>
#include <ArduinoJson.h>
#include "VirtualRTCProvider.h"

class ServerCallbacks : public NimBLEServerCallbacks
{
public:
    ServerCallbacks(void *provider);

private:
    void *_provider;
    void onConnect(NimBLEServer *pServer, ble_gap_conn_desc *desc);
    void onDisconnect(NimBLEServer *pServer);
};
#endif