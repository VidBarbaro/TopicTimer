#ifndef CHARACTERISTICCALLBACKS_H
#define CHARACTERISTICCALLBACKS_H

#include <NimBLEDevice.h>
#include "BLEProvider.h"

class CharacteristicCallbacks : public NimBLECharacteristicCallbacks
{
    public:
        CharacteristicCallbacks(void* provider);
    private:
        void* _provider;
        void onRead(NimBLECharacteristic* pCharacteristic);
        void onWrite(NimBLECharacteristic* pCharacteristic);
        bool handleMessage(String message);
};

#endif