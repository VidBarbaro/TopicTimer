#include "VibrateAction.h"

void VibrateAction::start(int pin)
{
    int mappedStrength = map(WatchSettings::get<int>(vibrationLevel), WatchSettings::get<int>(vibrationLevel, -1), WatchSettings::get<int>(vibrationLevel, 1), 0, 255);
    _pwm.write(pin, mappedStrength);
    _startTime = millis();
}

void VibrateAction::update()
{
    // VibrateAction does not require update to be called
}

bool VibrateAction::isFinished() const
{
    return millis() - _startTime >= _duration;
}
