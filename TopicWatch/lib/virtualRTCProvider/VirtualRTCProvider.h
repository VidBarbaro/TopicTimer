#ifndef VIRTUAL_RTC_PROVIDER
#define VIRTUAL_RTC_PROVIDER

#include "Arduino.h"

struct DateTime
{
    int hours = 0;
    int minutes = 0;
    int seconds = 0;
    int year = 0;
    int month = 0;
    int day = 0;
};

class VirtualRTCProvider
{
private:
    static const int _numberOfDaysInTheMonth[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    static hw_timer_t *_timer;
    const uint64_t _sleepTime = 1 * 1000000; // 1 second(s)
    static DateTime _dateTime;
    static DateTime _trackingDateTime;
    static int _isTracking = false;

    static void IRAM_ATTR onTimer();
    static void increaseTime();
    static void increaseDate();
    static void increaseTrackingTime();
    static void increaseTrackingDate();

public:
    VirtualRTCProvider();
    ~VirtualRTCProvider() = default;
    void setTime(int hours, int minutes, int seconds, int year, int month, int day);
    DateTime *getTime();
    void startTopicTimer();
    DateTime stopTopicTimer();
};

#endif