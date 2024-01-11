#ifndef VIRTUAL_RTC_PROVIDER
#define VIRTUAL_RTC_PROVIDER

#include "Arduino.h"
#include "WatchSettings.h"
#include "TrackingInfo.h"

class VirtualRTCProvider
{
private:
    static hw_timer_t *_timer;
    const uint64_t _sleepTime = 1 * 1000000; // 1 second(s)
    static DateTime _dateTime;
    static DateTime _trackingDateTime;
    static TrackingInfo _trackingInfo;
    static int _isTracking;
    static int _trackingIsPaused;

    static void IRAM_ATTR onTimer();
    static void increaseTime();
    static void increaseDate();
    static void increaseTrackingTime();
    static void increaseTrackingDate();
    void clearDateTime(DateTime *dateTimeToClear);

public:
    VirtualRTCProvider();
    ~VirtualRTCProvider() = default;
    static void setTime(int hours, int minutes, int seconds, int year, int month, int day);
    static void clearTrackTime(void);
    DateTime *getTime();
    DateTime *getTrackingTime();
    void startTopicTimer();
    void togglePauseTopicTimer();
    TrackingInfo stopTopicTimer();
};

#endif