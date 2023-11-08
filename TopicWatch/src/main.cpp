#include "Arduino.h"
#include "Border.h"
#include "PinConfig.h"
#include "TFT_eSPI.h"

TFT_eSPI tft = TFT_eSPI();
Border border = Border(&tft, 3);

int percentage = 0;

void setup()
{
    pinMode(PIN_POWER_ON, OUTPUT);
    digitalWrite(PIN_POWER_ON, HIGH);

    tft.begin();
    tft.setRotation(1);

    tft.setTextSize(2);
    tft.fillScreen(TFT_BLACK);
    tft.setTextColor(TFT_GREEN, TFT_BLACK);

    tft.drawString("TopicWatch!", 100, 50);
}

void loop()
{
    if (percentage > 100)
    {
        delay(1000);
        border.clear(TFT_BLACK);
        percentage = 0;
        delay(5000);
    }
    else
    {
        border.set(percentage, (uint32_t)0xFFFF00);
        percentage++;
        delay(50);
    }
}