#include "VibrationPattern_1.h"

void VibrationPattern_1::start()
{
    if (WatchSettings::get<int>(vibrationLevel) == 0)
    {
        return;
    }

    _currentActionIndex = 0;
    _patternStarted = true;
    _actions[_currentActionIndex]->start(WatchSettings::get<int>(vibrationMotorPin), &_pwm);
}

void VibrationPattern_1::update()
{
    if (_patternStarted)
    {
        _actions[_currentActionIndex]->update();
        if (_actions[_currentActionIndex]->isFinished())
        {
            _currentActionIndex++;

            if (_currentActionIndex < _amountOfActions && _actions[_currentActionIndex] != nullptr)
            {
                _actions[_currentActionIndex]->start(WatchSettings::get<int>(vibrationMotorPin), &_pwm);
            }
            else
            {
                _patternStarted = false;
            }
        }
    }
}

void VibrationPattern_1::cancel()
{
    if (_patternStarted)
    {
        _actions[_currentActionIndex]->cancel();
        _patternStarted = false;
    }
}

bool VibrationPattern_1::isFinished() const
{
    return !_patternStarted;
}
