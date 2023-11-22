#ifndef CHARACTERISTICCALLBACKS_H
#define CHARACTERISTICCALLBACKS_H

#include <NimBLEDevice.h>
#include "BLEProvider.h"

class CharacteristicCallbacks : public NimBLECharacteristicCallbacks
{
    public:
        CharacteristicCallbacks() = default;
    private:
        void onRead(NimBLECharacteristic* pCharacteristic);
        void onWrite(NimBLECharacteristic* pCharacteristic);
};

#endif