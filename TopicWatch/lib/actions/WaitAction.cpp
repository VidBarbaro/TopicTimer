#include "WaitAction.h"

void WaitAction::start(int pin)
{
    _pin = pin;
    analogWrite(_pin, 0);
    _startTime = millis();
}

void WaitAction::update()
{
    analogWrite(_pin, 0);
}

void WaitAction::cancel()
{
    analogWrite(_pin, 0);
}

bool WaitAction::isFinished()
{
    if (millis() - _startTime >= _duration)
    {
        analogWrite(_pin, 0);
        return true;
    }

    return false;
}