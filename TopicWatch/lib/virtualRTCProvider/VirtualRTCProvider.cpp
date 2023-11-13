#include "VirtualRTCProvider.h"

hw_timer_t *VirtualRTCProvider::_timer;
DateTime VirtualRTCProvider::_dateTime;

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
    static const int _numberOfDaysInTheMonth[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

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