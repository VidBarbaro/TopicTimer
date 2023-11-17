#include "VirtualRTCProvider.h"

hw_timer_t *VirtualRTCProvider::_timer;
DateTime VirtualRTCProvider::_dateTime;
DateTime VirtualRTCProvider::_trackingDateTime;
int VirtualRTCProvider::_isTracking = false;

VirtualRTCProvider::VirtualRTCProvider()
{
    _timer = timerBegin(0, 80, true);

    timerAttachInterrupt(_timer, &VirtualRTCProvider::onTimer, true);
    timerAlarmWrite(_timer, _sleepTime, true);
    timerAlarmEnable(_timer);

    setTime(0, 0, 0, 2023, 11, 13);
}

void IRAM_ATTR VirtualRTCProvider::onTimer()
{
    increaseTime();
    if (_isTracking)
    {
        increaseTrackingTime();
    }
}

void VirtualRTCProvider::increaseTime()
{
    _dateTime.seconds++;

    if (_dateTime.seconds >= 60)
    {
        _dateTime.seconds = 0;
        _dateTime.minutes++;

        if (_dateTime.minutes >= 60)
        {
            _dateTime.minutes = 0;
            _dateTime.hours++;

            if (_dateTime.hours >= 24)
            {
                _dateTime.hours = 0;
                increaseDate();
            }
        }
    }
}

void VirtualRTCProvider::increaseDate()
{
    _dateTime.day++;

    if (_dateTime.day >= _numberOfDaysInTheMonth[_dateTime.month - 1] + 1)
    {
        _dateTime.day = 1;
        _dateTime.month++;

        if (_dateTime.month >= 13)
        {
            _dateTime.month = 1;
            _dateTime.year++;
        }
    }
}

void VirtualRTCProvider::increaseTrackingTime()
{
    _trackingDateTime.seconds++;

    if (_trackingDateTime.seconds >= 60)
    {
        _trackingDateTime.seconds = 0;
        _trackingDateTime.minutes++;

        if (_trackingDateTime.minutes >= 60)
        {
            _trackingDateTime.minutes = 0;
            _trackingDateTime.hours++;

            if (_trackingDateTime.hours >= 24)
            {
                _trackingDateTime.hours = 0;
                increaseTrackingDate();
            }
        }
    }
}

void VirtualRTCProvider::increaseTrackingDate()
{
    _trackingDateTime.day++;

    if (_trackingDateTime.day >= _numberOfDaysInTheMonth[_dateTime.month - 1] + 1)
    {
        _trackingDateTime.day = 1;
        _trackingDateTime.month++;

        if (_trackingDateTime.month >= 13)
        {
            _trackingDateTime.month = 1;
            _trackingDateTime.year++;
        }
    }
}

void VirtualRTCProvider::setTime(int hours, int minutes, int seconds, int year, int month, int day)
{
    _dateTime.hours = hours;
    _dateTime.minutes = minutes;
    _dateTime.seconds = seconds;
    _dateTime.year = year;
    _dateTime.month = month;
    _dateTime.day = day;
}

DateTime *VirtualRTCProvider::getTime()
{
    return &_dateTime;
}

void VirtualRTCProvider::startTopicTimer()
{
    if (!_isTracking)
    {
        _trackingDateTime.hours = 0;
        _trackingDateTime.minutes = 0;
        _trackingDateTime.seconds = 0;
        _trackingDateTime.year = 0;
        _trackingDateTime.month = 0;
        _trackingDateTime.day = 0;
    }

    _isTracking = true;
}

DateTime VirtualRTCProvider::stopTopicTimer()
{
    _isTracking = false;
    return _trackingDateTime;
}
