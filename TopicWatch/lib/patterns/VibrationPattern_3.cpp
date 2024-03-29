#include "VibrationPattern_3.h"

VibrationPattern_3::~VibrationPattern_3()
{
    for (int i = 0; i < _amountOfActions; i++)
    {
        delete _actions[i];
        _actions[i] = nullptr;
    }
}

bool VibrationPattern_3::start()
{
    if (WatchSettings::get<int>(vibrationLevel) == 0)
    {
        return false;
    }

    _currentActionIndex = 0;
    _patternStarted = true;
    _actions[_currentActionIndex]->start(WatchSettings::get<int>(vibrationMotorPin));
    _isPlaying = true;
    return true;
}

void VibrationPattern_3::update()
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
                _isPlaying = false;
            }
        }
    }
}

void VibrationPattern_3::cancel()
{
    if (_patternStarted)
    {
        _actions[_currentActionIndex]->cancel();
        _patternStarted = false;
        _isPlaying = false;
    }
}

bool VibrationPattern_3::isFinished()
{
    if (!_isPlaying && _patternStarted)
    {
        _patternStarted = false;
        return true;
    }
    return false;
}
