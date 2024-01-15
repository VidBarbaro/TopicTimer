#include "SoundPattern_4.h"

SoundPattern_4::~SoundPattern_4()
{
    for (int i = 0; i < _amountOfActions; i++)
    {
        delete _actions[i];
        _actions[i] = nullptr;
    }
}

bool SoundPattern_4::start()
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

void SoundPattern_4::update()
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

void SoundPattern_4::cancel()
{
    if (_patternStarted)
    {
        _actions[_currentActionIndex]->cancel();
        _patternStarted = false;
        _isPlaying = false;
    }
}

bool SoundPattern_4::isFinished()
{
    if (!_isPlaying && _patternStarted)
    {
        _patternStarted = false;
        return true;
    }
    return false;
}
