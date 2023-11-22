#ifndef BLE_PROVIDER
#define BLE_PROVIDER

#include "BLEConfig.h"
#include <NimBLEDevice.h>
#include "ArduinoJson.h"
#include "CharacteristicCallbacks.h"
#include "ServerCallbacks.h"

class BLEProvider
{
    private:
        NimBLEServer *_pServer;
        NimBLECharacteristic *_pCharacteristic; //Primary characteristic to write too

    public:
        BLEProvider() = default;
        ~BLEProvider() = default;
        void init(void);
        void write(String value);
        void sendTimeRequest(void);
        void sendTopicsRequest(void);
        void sendTrackedTimes(void);
};

#endif