#include <NimBLEDevice.h>

class ServerCallbacks : public NimBLEServerCallbacks
{
    public:
        ServerCallbacks() = default;
    private:
        void onConnect(NimBLEServer *pServer, ble_gap_conn_desc *desc);
        void onDisconnect(NimBLEServer* pServer);
};