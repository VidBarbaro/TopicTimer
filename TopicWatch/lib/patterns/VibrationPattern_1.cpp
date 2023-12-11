#include "VibrationPattern_1.h"

void VibrationPattern_1::start()
{
    _currentActionIndex = 0;
    _patternStarted = true;
    _actions[_currentActionIndex]->start(WatchSettings::get<int>(vibrationMotorPin));
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
                _actions[_currentActionIndex]->start(WatchSettings::get<int>(vibrationMotorPin));
            }
            else
            {
                _patternStarted = false;
            }
        }
    }
}

bool VibrationPattern_1::isFinished() const
{
    return !_patternStarted;
}
