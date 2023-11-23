#ifndef BLE_PROVIDER
#define BLE_PROVIDER

#include "BLEConfig.h"
#include <NimBLEDevice.h>
#include "ArduinoJson.h"
#include "CharacteristicCallbacks.h"
#include "ServerCallbacks.h"

typedef void (*SetTimeCallback)(int hours, int minutes, int seconds, int year, int month, int day);

class BLEProvider
{

private:
    BLEProvider *_instance;
    NimBLEServer *_pServer;
    NimBLECharacteristic *_pCharacteristic; // Primary characteristic to write too
    int _connectionState = false;
    int _stateChanged = false;

public:
    SetTimeCallback setTimeCallback = nullptr;

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