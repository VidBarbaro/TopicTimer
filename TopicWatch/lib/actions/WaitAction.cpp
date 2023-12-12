#include "WaitAction.h"

void WaitAction::start(int pin, Pwm *pwm)
{
    if (pwm == nullptr)
    {
        return;
    }

    _pwm = pwm;
    _pwm->write(pin, 0);
    _pin = pin;
    _startTime = millis();
}

void WaitAction::update()
{
    if (_pwm == nullptr)
    {
        return;
    }

    _pwm->write(_pin, 0);
}

void WaitAction::cancel()
{
    if (_pwm == nullptr)
    {
        return;
    }

    _pwm->write(_pin, 0);
}

bool WaitAction::isFinished()
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