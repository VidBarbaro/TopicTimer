#include "VibrateAction.h"

void VibrateAction::start(int pin)
{
    int mappedStrength = WatchSettings::get<int>(vibrationLevel) > 0 ? map(WatchSettings::get<int>(vibrationLevel), WatchSettings::get<int>(vibrationLevel, -1), WatchSettings::get<int>(vibrationLevel, 1), 125, 255) : 0;
    analogWrite(pin, mappedStrength);
    _pin = pin;
    _startTime = millis();
}

void VibrateAction::update()
{
    // VibrateAction does not require update to be called
}

void VibrateAction::cancel()
{
    analogWrite(_pin, 0);
}

bool VibrateAction::isFinished()
{
    if (millis() - _startTime >= _duration)
    {
        analogWrite(_pin, 0);
        return true;
    }

    return false;
}
