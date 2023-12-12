#include "VibrationPattern_2.h"

void VibrationPattern_2::start()
{
    if (WatchSettings::get<int>(vibrationLevel) == 0)
    {
        return;
    }

    _currentActionIndex = 0;
    _patternStarted = true;
    _actions[_currentActionIndex]->start(WatchSettings::get<int>(vibrationMotorPin));
}

void VibrationPattern_2::update()
{
    if (_patternStarted)
    {
        _actions[_currentActionIndex]->update();
        if (_actions[_currentActionIndex]->isFinished())
        {
            _currentActionIndex++;

            if (_currentActionIndex < _amountOfActions && _actions[_currentActionIndex] != nullptr)
            {
                _actions[_currentActionIndex]->start(WatchSettings::get<int>(vibrationMotorPin));
            }
            else
            {
                _patternStarted = false;
            }
        }
    }
}

void VibrationPattern_2::cancel()
{
    if (_patternStarted)
    {
        _actions[_currentActionIndex]->cancel();
        _patternStarted = false;
    }
}

bool VibrationPattern_2::isFinished() const
{
    return !_patternStarted;
}
