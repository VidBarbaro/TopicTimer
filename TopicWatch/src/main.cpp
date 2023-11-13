#include "Arduino.h"
#include "BLEProvider.h"
#include "Border.h"
#include "PinConfig.h"
#include "StringHelper.h"
#include "TFT_eSPI.h"
#include "VirtualRTCProvider.h"

void onConnected();
void onDisconnected();
void onRead(const char *value);
void onWrite(const char *value);

TFT_eSPI tft = TFT_eSPI();
// BLEProvider bleProvider = BLEProvider(onConnected, onDisconnected, onRead, onWrite);
Border border = Border(&tft, 3);
VirtualRTCProvider vrp = VirtualRTCProvider();
DateTime *dt = vrp.getTime();

int percentage = 0;

bool connected = false;
bool sendRequest = false;
bool waitingForAnswer = false;

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
     * Print BLE details
     */
    tft.setTextSize(1);
    tft.drawString(BLE_DEVICE_NAME, 50, 10);
    border.set(100, TFT_RED);

    tft.setTextSize(5);
    tft.setTextDatum(MC_DATUM);
}

void loop()
{
    if (connected && !sendRequest)
    {
        border.set(100, 0x009688);
        // bleProvider.write("Time?");
        sendRequest = true;
        waitingForAnswer = true;
    }

    String s = StringHelper::padZeroLeft(String(dt->hours)) + ':' + StringHelper::padZeroLeft(String(dt->minutes)) + ':' + StringHelper::padZeroLeft(String(dt->seconds));
    tft.drawString(s, tft.width() / 2, tft.height() / 2);
}

void onConnected()
{
    border.set(100, 0x009688);
}

void onDisconnected()
{
    border.set(100, TFT_RED);
}

void onRead(const char *value)
{
    tft.drawString(String(value), 50, 100);
}

void onWrite(const char *value)
{
    tft.drawString(String(value), 50, 100);
}
