#include "SoundPattern_1.h"

void SoundPattern_1::start()
{
    if (WatchSettings::get<int>(soundLevel) == 0)
    {
        return;
    }

    _currentActionIndex = 0;
    _patternStarted = true;
    _actions[_currentActionIndex]->start(WatchSettings::get<int>(buzzerPin));
}

void SoundPattern_1::update()
{
    if (_patternStarted)
    {
        _actions[_currentActionIndex]->update();
        if (_actions[_currentActionIndex]->isFinished())
        {
            _currentActionIndex++;

            if (_currentActionIndex < _amountOfActions && _actions[_currentActionIndex] != nullptr)
            {
                _actions[_currentActionIndex]->start(WatchSettings::get<int>(buzzerPin));
            }
            else
            {
                _patternStarted = false;
            }
        }
    }
}

void SoundPattern_1::cancel()
{
    if (_patternStarted)
    {
        _actions[_currentActionIndex]->cancel();
        _patternStarted = false;
    }
}

bool SoundPattern_1::isFinished() const
{
    return !_patternStarted;
}
