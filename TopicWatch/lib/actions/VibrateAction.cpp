#include "VibrateAction.h"

void VibrateAction::start(int pin, Pwm *pwm)
{
    if (pwm == nullptr)
    {
        return;
    }

    int mappedStrength = WatchSettings::get<int>(vibrationLevel) > 0 ? map(WatchSettings::get<int>(vibrationLevel), WatchSettings::get<int>(vibrationLevel, -1), WatchSettings::get<int>(vibrationLevel, 1), 100, 255) : 0;
    _pwm = pwm;
    _pwm->write(pin, mappedStrength);
    _pin = pin;
    _startTime = millis();
}

void VibrateAction::update()
{
    // VibrateAction does not require update to be called
}

void VibrateAction::cancel()
{
    if (_pwm == nullptr)
    {
        return;
    }

    _pwm->write(_pin, 0);
}

bool VibrateAction::isFinished()
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
