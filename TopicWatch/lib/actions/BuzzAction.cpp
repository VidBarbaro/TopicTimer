#include "BuzzAction.h"

void BuzzAction::start(int pin)
{
    int mappedStrength = map(WatchSettings::get<int>(soundLevel), WatchSettings::get<int>(soundLevel, -1), WatchSettings::get<int>(soundLevel, 1), 0, 50);
    analogWrite(pin, mappedStrength);
    _pin = pin;
    _startTime = millis();
}

void BuzzAction::update()
{
    // BuzzAction does not require update to be called
}

void BuzzAction::cancel()
{
    analogWrite(_pin, 0);
}

bool BuzzAction::isFinished()
{
    if (millis() - _startTime >= _duration)
    {
        analogWrite(_pin, 0);
        return true;
    }

    return false;
}
