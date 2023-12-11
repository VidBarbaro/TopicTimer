#include "WaitAction.h"

void WaitAction::start(int pin)
{
    _pwm.write(pin, 0);
    _startTime = millis();
}

void WaitAction::update()
{
    // WaitAction does not require update to be called
}

bool WaitAction::isFinished() const
{
    return millis() - _startTime >= _duration;
}