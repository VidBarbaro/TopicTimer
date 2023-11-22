#ifndef WATCH_SETTINGS
#define WATCH_SETTINGS

class WatchSettings
{
private:
public:
    static const int maxAmountOfViews = 100;
    static const int minimalTrackingMinutes = 5;
    static const uint32_t topicTimer_GREEN = 0x009688;
    static const uint32_t topicTimer_ORANGE = 0xFFC107;
    static const uint32_t topicTimer_BLUE = 0x03A9F4;
    static const uint32_t topicTimer_GRAY = TFT_BLACK;
    static const uint32_t topicTimer_BLACK = 0x333333;

    WatchSettings() = delete;
    ~WatchSettings() = default;
};

#endif