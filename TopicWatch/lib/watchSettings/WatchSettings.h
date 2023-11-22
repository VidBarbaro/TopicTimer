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
    static const int marginFromBorder = 8;
    static const uint32_t topicTimer_GREEN = 0x009688;
    static const uint32_t topicTimer_ORANGE = 0xFFC107;
    static const uint32_t topicTimer_BLUE = 0x03A9F4;
    static const uint32_t topicTimer_GRAY = TFT_BLACK;
    static const uint32_t topicTimer_BLACK = 0x333333;

    WatchSettings() = delete;
    ~WatchSettings() = default;
};

#endif