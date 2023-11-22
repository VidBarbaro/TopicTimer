#ifndef WATCH_SETTINGS
#define WATCH_SETTINGS

#include "TFT_eSPI.h"

class WatchSettings
{
private:
public:
    static const int maxAmountOfViews = 100;
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
};

#endif