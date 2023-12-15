#include "VirtualRTCProvider.h"

hw_timer_t *VirtualRTCProvider::_timer;
DateTime VirtualRTCProvider::_dateTime;
DateTime VirtualRTCProvider::_trackingDateTime;
TrackingInfo VirtualRTCProvider::_trackingInfo;
int VirtualRTCProvider::_isTracking = false;
int VirtualRTCProvider::_trackingIsPaused = false;

VirtualRTCProvider::VirtualRTCProvider()
{
    _timer = timerBegin(0, 80, true);

    timerAttachInterrupt(_timer, &VirtualRTCProvider::onTimer, true);
    timerAlarmWrite(_timer, _sleepTime, true);
    timerAlarmEnable(_timer);

    setTime(10, 43, 34, 2023, 11, 17);
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
    const int _numberOfDaysInTheMonth[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

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
    if (_trackingIsPaused)
    {
        return;
    }

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
    const int _numberOfDaysInTheMonth[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

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

void VirtualRTCProvider::clearDateTime(DateTime *dateTimeToClear)
{
    dateTimeToClear->hours = 0;
    dateTimeToClear->minutes = 0;
    dateTimeToClear->seconds = 0;
    dateTimeToClear->year = 0;
    dateTimeToClear->month = 0;
    dateTimeToClear->day = 0;
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

void VirtualRTCProvider::clearTrackTime()
{
    _trackingInfo.startTime.hours = 0;
    _trackingInfo.startTime.minutes = 0;
    _trackingInfo.startTime.seconds = 0;
    _trackingInfo.startTime.year = 0;
    _trackingInfo.startTime.month = 0;
    _trackingInfo.startTime.day = 0;

    _trackingInfo.endTime.hours = 0;
    _trackingInfo.endTime.minutes = 0;
    _trackingInfo.endTime.seconds = 0;
    _trackingInfo.endTime.year = 0;
    _trackingInfo.endTime.month = 0;
    _trackingInfo.endTime.day = 0;

    _trackingInfo.topicId = "";
}

DateTime *VirtualRTCProvider::getTime()
{
    return &_dateTime;
}

DateTime *VirtualRTCProvider::getTrackingTime()
{
    return &_trackingDateTime;
}

void VirtualRTCProvider::startTopicTimer()
{
    if (!_isTracking)
    {
        clearDateTime(&_trackingDateTime);

        _trackingInfo.startTime = _dateTime;
    }

    _isTracking = true;
}

void VirtualRTCProvider::togglePauseTopicTimer()
{
    if (_isTracking)
    {
        _trackingIsPaused = !_trackingIsPaused;
    }
}

TrackingInfo VirtualRTCProvider::stopTopicTimer()
{
    if (_trackingDateTime.minutes < WatchSettings::get<int>(minimalTrackingMinutes))
    {
        clearDateTime(&_trackingInfo.startTime);
        clearDateTime(&_trackingInfo.endTime);
    }
    else
    {
        _trackingInfo.endTime = _dateTime;
    }

    _trackingInfo.topicId = "Yet to be set"; // gets set in function: TopicView::stopTracking()
    _isTracking = false;
    return _trackingInfo;
}
