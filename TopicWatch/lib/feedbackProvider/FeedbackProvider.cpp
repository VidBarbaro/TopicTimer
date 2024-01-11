#include "FeedbackProvider.h"

FeedbackPattern *FeedbackProvider::_currentPattern = nullptr;
VibrationFeedbackPattern *FeedbackProvider::_vibrationPattern = nullptr;
SoundFeedbackPattern *FeedbackProvider::_soundPattern = nullptr;

void FeedbackProvider::setVibrationPattern(VibrationFeedbackPattern *pattern)
{
    delete _vibrationPattern;
    _vibrationPattern = pattern;
}

void FeedbackProvider::setSoundPattern(SoundFeedbackPattern *pattern)
{
    delete _soundPattern;
    _soundPattern = pattern;
}

void FeedbackProvider::playPattern()
{
    if (_vibrationPattern != nullptr)
    {
        if (!_vibrationPattern->start())
        {
            cancel(_vibrationPattern);
        }
    }

    if (_soundPattern != nullptr)
    {
        if (!_soundPattern->start())
        {
            cancel(_soundPattern);
        }
    }
}

void FeedbackProvider::playPattern(FeedbackPattern *pattern)
{
    if (_currentPattern == nullptr && pattern != nullptr)
    {
        _currentPattern = pattern;
        if (!_currentPattern->start())
        {
            cancel(_currentPattern);
        }
    }
}

void FeedbackProvider::update()
{
    if (_currentPattern != nullptr)
    {
        _currentPattern->update();

        if (_currentPattern->isFinished())
        {
            cancel(_currentPattern);
        }
    }

    if (_vibrationPattern != nullptr)
    {
        _vibrationPattern->update();

        if (_vibrationPattern->isFinished())
        {
            cancel(_vibrationPattern);
        }
    }

    if (_soundPattern != nullptr)
    {
        _soundPattern->update();

        if (_soundPattern->isFinished())
        {
            cancel(_soundPattern);
        }
    }
}

void FeedbackProvider::cancel()
{
    cancel(_currentPattern);
    cancel(_vibrationPattern);
    cancel(_soundPattern);
}

void FeedbackProvider::cancel(FeedbackPattern *&pattern)
{
    if (pattern != nullptr)
    {
        pattern->cancel();

        delete pattern;
        pattern = nullptr;
    }
}

void FeedbackProvider::cancel(VibrationFeedbackPattern *&pattern)
{
    if (pattern != nullptr)
    {
        pattern->cancel();
    }
}

void FeedbackProvider::cancel(SoundFeedbackPattern *&pattern)
{
    if (pattern != nullptr)
    {
        pattern->cancel();
    }
}