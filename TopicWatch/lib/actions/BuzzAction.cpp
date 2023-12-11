#include "BuzzAction.h"

void BuzzAction::start(int pin)
{
    int mappedStrength = map(WatchSettings::get<int>(soundLevel), WatchSettings::get<int>(soundLevel, -1), WatchSettings::get<int>(soundLevel, 1), 0, 255);
    _pwm.write(pin, mappedStrength);
    _startTime = millis();
}

void BuzzAction::update()
{
    // BuzzAction does not require update to be called
}

bool BuzzAction::isFinished() const
{
    return millis() - _startTime >= _duration;
}
