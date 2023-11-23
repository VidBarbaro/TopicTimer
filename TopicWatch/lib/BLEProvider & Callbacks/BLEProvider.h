#ifndef BLE_PROVIDER
#define BLE_PROVIDER

#include "BLEConfig.h"
#include <NimBLEDevice.h>
#include "ArduinoJson.h"
#include "CharacteristicCallbacks.h"
#include "ServerCallbacks.h"
#include "VirtualRTCProvider.h"

class BLEProvider
{
private:
    BLEProvider *_instance;
    NimBLEServer *_pServer;
    NimBLECharacteristic *_pCharacteristic; // Primary characteristic to write too
    int _connectionState = false;
    int _stateChanged = false;

public:
    BLEProvider() = default;
    ~BLEProvider() = default;
    void init();
    bool write(String value);
    void sendTimeRequest(void);
    void sendTopicsRequest(void);
    void sendTrackedTimes(void);
    void setConnectionState(bool newState);
    int getConnectionState(void);
};

#endif