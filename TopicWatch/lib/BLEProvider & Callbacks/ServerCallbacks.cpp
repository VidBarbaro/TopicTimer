#include "ServerCallbacks.h"

void ServerCallbacks::sendTimeRequest(NimBLECharacteristic* charateristic)
{
    StaticJsonDocument<100> doc;

    doc["command"] = "getTime";
    String message = " ";   
    serializeJson(doc, message);
    charateristic->setValue(message);
    charateristic->notify();
}

void ServerCallbacks::onConnect(NimBLEServer *pServer, ble_gap_conn_desc *desc)
{
    Serial.print("Client address: ");
    Serial.println(NimBLEAddress(desc->peer_ota_addr).toString().c_str());
    pServer->updateConnParams(desc->conn_handle, 24, 48, 0, 60);
}
void ServerCallbacks::onDisconnect(NimBLEServer *pServer)
{
    Serial.println("Client disconnected - start advertising");
    NimBLEDevice::startAdvertising();
}