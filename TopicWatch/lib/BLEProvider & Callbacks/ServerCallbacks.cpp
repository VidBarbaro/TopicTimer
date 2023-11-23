#include "ServerCallbacks.h"

ServerCallbacks::ServerCallbacks(void* provider)
{
    _provider = provider;
}

void ServerCallbacks::onConnect(NimBLEServer *pServer, ble_gap_conn_desc *desc)
{
    BLEProvider* bleProvider = (BLEProvider*)_provider;

    Serial.print("Client address: ");
    Serial.println(NimBLEAddress(desc->peer_ota_addr).toString().c_str());
    pServer->updateConnParams(desc->conn_handle, 24, 48, 0, 60);

    bleProvider->setConnectionState(true);

    bleProvider->sendTimeRequest();
}
void ServerCallbacks::onDisconnect(NimBLEServer *pServer)
{
    BLEProvider *bleProvider = (BLEProvider *)_provider;

    Serial.println("Client disconnected - start advertising");

    bleProvider->setConnectionState(false);

    NimBLEDevice::startAdvertising();
}