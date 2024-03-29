#include "SoundPattern_5.h"

SoundPattern_5::~SoundPattern_5()
{
    for (int i = 0; i < _amountOfActions; i++)
    {
        delete _actions[i];
        _actions[i] = nullptr;
    }
}

bool SoundPattern_5::start()
{
    if (WatchSettings::get<int>(soundLevel) == 0)
    {
        return false;
    }

    _currentActionIndex = 0;
    _patternStarted = true;
    _actions[_currentActionIndex]->start(WatchSettings::get<int>(buzzerPin));
    _isPlaying = true;
    return true;
}

void SoundPattern_5::update()
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
                _isPlaying = false;
            }
        }
    }
}

void SoundPattern_5::cancel()
{
    if (_patternStarted)
    {
        _actions[_currentActionIndex]->cancel();
        _patternStarted = false;
        _isPlaying = false;
    }
}

bool SoundPattern_5::isFinished()
{
    if (!_isPlaying && _patternStarted)
    {
        _patternStarted = false;
        return true;
    }
    return false;
}
