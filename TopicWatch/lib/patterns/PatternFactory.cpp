#include "PatternFactory.h"

VibrationFeedbackPattern *PatternFactory::createVibrationPattern(int patternValue)
{
    switch (patternValue)
    {
    case 1:
        return new VibrationPattern_1();
    case 2:
        return new VibrationPattern_2();
    default:
        return nullptr;
    }
}

SoundFeedbackPattern *PatternFactory::createSoundPattern(int patternValue)
{
    switch (patternValue)
    {
    case 1:
        return new SoundPattern_1();
    // case 2:
    //     return new SoundPattern_2();
    default:
        return nullptr;
    }
}
