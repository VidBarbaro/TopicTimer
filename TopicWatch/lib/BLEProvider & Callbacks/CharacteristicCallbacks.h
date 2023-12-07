#ifndef CHARACTERISTICCALLBACKS_H
#define CHARACTERISTICCALLBACKS_H

#include <NimBLEDevice.h>
#include "BLEProvider.h"
#include "ViewController.h"

class CharacteristicCallbacks : public NimBLECharacteristicCallbacks
{
public:
    CharacteristicCallbacks(void *provider);

private:
    void *_provider;
    void onRead(NimBLECharacteristic *pCharacteristic);
    void onWrite(NimBLECharacteristic *pCharacteristic);
    void onNotify(NimBLECharacteristic *pCharacteristic);
    bool handleMessage(String message, NimBLECharacteristic *pCharacteristic);
};

#endif