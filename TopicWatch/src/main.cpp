#include "Arduino.h"
#include "BLEConfig.h"
#include "Border.h"
#include "NimBLEDevice.h"
#include "PinConfig.h"
#include "TFT_eSPI.h"

TFT_eSPI tft = TFT_eSPI();
Border border = Border(&tft, 3);

int percentage = 0;

bool connected = false;
bool sendRequest = false;
bool waitingForAnswer = false;

static NimBLEServer *pTopicWatchServer;
NimBLEService *pTopicWatchService;
NimBLECharacteristic *pTopicWatchCharacteristic;

/**  None of these are required as they will be handled by the library with defaults. **
 **                       Remove as you see fit for your needs                        */
class ServerCallbacks : public NimBLEServerCallbacks
{
    void onConnect(NimBLEServer *pServer, ble_gap_conn_desc *desc)
    {
        connected = true;
        NimBLEDevice::stopAdvertising();
    };

    void onDisconnect(NimBLEServer *pServer)
    {
        connected = false;
        NimBLEDevice::startAdvertising();
    };
};

/** Handler class for characteristic actions */
class CharacteristicCallbacks : public NimBLECharacteristicCallbacks
{
    void onRead(NimBLECharacteristic *pCharacteristic)
    {
        String s = "Read: ";
        s += pCharacteristic->getValue().c_str();
        Serial.print(pCharacteristic->getUUID().toString().c_str());
        Serial.print(": onRead(), value: ");
        Serial.println(pCharacteristic->getValue().c_str());
        tft.drawString(s, 50, 80);
    };

    void onWrite(NimBLECharacteristic *pCharacteristic)
    {
        if (waitingForAnswer)
        {
            border.set(100, TFT_YELLOW);

            String s = pCharacteristic->getValue().c_str();
            tft.setTextSize(5);
            tft.setTextDatum(MC_DATUM);
            tft.drawString(s, tft.width() / 2, tft.height() / 2);

            waitingForAnswer = false;
        }
    };
    /** Called before notification or indication is sent,
     *  the value can be changed here before sending if desired.
     */
    void onNotify(NimBLECharacteristic *pCharacteristic)
    {
        Serial.println("Sending notification to clients");
    };
};

void setup()
{
    Serial.begin(9600);
    /*
     * Turn on and initialize the screen
     */
    pinMode(PIN_POWER_ON, OUTPUT);
    digitalWrite(PIN_POWER_ON, HIGH);

    tft.begin();
    tft.setRotation(1);
    tft.fillScreen(TFT_BLACK);

    /*
     * Create BLE server
     */
    NimBLEDevice::init("TopicWatch");

    /** Optional: set the transmit power, default is 3db */
#ifdef ESP_PLATFORM
    NimBLEDevice::setPower(ESP_PWR_LVL_P21); /** +9db */
#else
    NimBLEDevice::setPower(9); /** +9db */
#endif
    NimBLEDevice::setSecurityAuth(false, false, false);

    pTopicWatchServer = NimBLEDevice::createServer();
    pTopicWatchServer->setCallbacks(new ServerCallbacks());

    pTopicWatchService = pTopicWatchServer->createService(BLE_UUID_SERVICE);
    pTopicWatchCharacteristic = pTopicWatchService->createCharacteristic(
        BLE_UUID_CHARACTERISTIC,
        NIMBLE_PROPERTY::READ |
            NIMBLE_PROPERTY::WRITE |
            NIMBLE_PROPERTY::NOTIFY);
    pTopicWatchCharacteristic->setCallbacks(new CharacteristicCallbacks());

    /** Start the services when finished creating all Characteristics and Descriptors */
    pTopicWatchService->start();

    NimBLEAdvertising *pAdvertising = NimBLEDevice::getAdvertising();
    /** Add the services to the advertisment data **/
    pAdvertising->addServiceUUID(pTopicWatchService->getUUID());
    /** If your device is battery powered you may consider setting scan response
     *  to false as it will extend battery life at the expense of less data sent.
     */
    pAdvertising->setScanResponse(true);
    pAdvertising->start();

    /*
     * Print BLE details
     */
    tft.setTextSize(1);
    tft.drawString(BLE_DEVICE_NAME, 50, 10);
    border.set(100, TFT_RED);
}

void loop()
{
    if (connected && !sendRequest)
    {
        border.set(100, 0x009688);
        delay(2000);
        pTopicWatchCharacteristic->setValue("Time?");
        pTopicWatchCharacteristic->notify();
        sendRequest = true;
        waitingForAnswer = true;
    }
}