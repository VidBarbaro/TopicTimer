#include "BuzzAction.h"

void BuzzAction::start(int pin, Pwm *pwm)
{
    if (pwm == nullptr)
    {
        return;
    }

    int mappedStrength = WatchSettings::get<int>(soundLevel) > 0 ? map(WatchSettings::get<int>(soundLevel), WatchSettings::get<int>(soundLevel, -1), WatchSettings::get<int>(soundLevel, 1), 0, 255) : 0;
    _pwm = pwm;
    _pwm->write(pin, mappedStrength);
    _pin = pin;
    _startTime = millis();
}

void BuzzAction::update()
{
    // BuzzAction does not require update to be called
}

void BuzzAction::cancel()
{
    if (_pwm == nullptr)
    {
        return;
    }

    _pwm->write(_pin, 0);
}

bool BuzzAction::isFinished()
{
    if (_pwm == nullptr)
    {
        return false;
    }

    if (millis() - _startTime >= _duration)
    {
        _pwm->write(_pin, 0);
        return true;
    }

    return false;
}
