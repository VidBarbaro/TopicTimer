#ifndef WATCH_SETTINGS
#define WATCH_SETTINGS

#include "TFT_eSPI.h"

class WatchSettings
{
private:
public:
    static const int amountOfNonTopicViews = 2;
    static const int maxAmountOfViews = 100 + amountOfNonTopicViews;
    static const int minimalTrackingMinutes = 5;
    static const int borderSize = 4;
    static const int marginFromBorder = 9;
    static const int textMargin = 17;
    static const int iconSize = 35;
    static const int iconMargin = 5;
    static const uint32_t topicTimer_GREEN_HEX = 0x009688;
    static uint16_t topicTimer_GREEN;
    static const uint32_t topicTimer_ORANGE_HEX = 0xFFC107;
    static uint16_t topicTimer_ORANGE;
    static const uint32_t topicTimer_BLUE_HEX = 0x03A9F4;
    static uint16_t topicTimer_BLUE;
    static const uint32_t topicTimer_GRAY_HEX = 0xF5F5F5;
    static uint16_t topicTimer_GRAY;
    static const uint32_t topicTimer_BLACK_HEX = 0x333333;
    static uint16_t topicTimer_BLACK;

    WatchSettings() = delete;
    ~WatchSettings() = default;

    static uint16_t convertHexTo565(uint32_t hexColor)
    {
        uint8_t red = (hexColor >> 16) & 0xFF;
        uint8_t green = (hexColor >> 8) & 0xFF;
        uint8_t blue = hexColor & 0xFF;

        uint16_t color565 = ((red & 0xF8) << 8) | ((green & 0xFC) << 3) | (blue >> 3);

        return color565;
    }
};

#endif