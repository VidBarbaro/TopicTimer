#include "FeedbackProvider.h"

FeedbackPattern *FeedbackProvider::_currentPattern = nullptr;

void FeedbackProvider::playPattern(FeedbackPattern *pattern)
{
    if (_currentPattern == nullptr && pattern != nullptr)
    {
        _currentPattern = pattern;
        _currentPattern->start();
    }
}

void FeedbackProvider::update()
{
    if (_currentPattern != nullptr)
    {
        _currentPattern->update();

        if (_currentPattern->isFinished())
        {
            cancel();
        }
    }
}

void FeedbackProvider::cancel()
{
    if (_currentPattern != nullptr)
    {
        _currentPattern->cancel();
        delete _currentPattern;
        _currentPattern = nullptr;
    }
}