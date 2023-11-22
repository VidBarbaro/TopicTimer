#include <NimBLEDevice.h>

class CharacteristicCallbacks : public NimBLECharacteristicCallbacks
{
    public:
        CharacteristicCallbacks() = default;
    private:
        void onRead(NimBLECharacteristic* pCharacteristic);
        void onWrite(NimBLECharacteristic* pCharacteristic);
};