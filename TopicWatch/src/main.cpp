#include "Arduino.h"
#include "BLEProvider.h"
#include "Border.h"
#include "PinConfig.h"
#include "StringHelper.h"
#include "TFT_eSPI.h"
#include "VirtualRTCProvider.h"

TFT_eSPI tft = TFT_eSPI();
Border border = Border(&tft, 3);
BLEProvider bleProvider;
VirtualRTCProvider vrp;
DateTime *dt = vrp.getTime();

int percentage = 0;

bool connected = false;
bool sendRequest = false;
bool waitingForAnswer = false;

void setup()
{
    bleProvider.init();

    /*
     * Turn on and initialize the screen
     */
    pinMode(PIN_POWER_ON, OUTPUT);
    digitalWrite(PIN_POWER_ON, HIGH);

    tft.begin();
    tft.setRotation(1);
    tft.fillScreen(TFT_BLACK);

    /*
     * Print initial border
     */
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
