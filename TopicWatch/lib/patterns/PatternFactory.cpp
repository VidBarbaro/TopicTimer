#include "PatternFactory.h"

VibrationFeedbackPattern *PatternFactory::createVibrationPattern(int patternValue)
{
    switch (patternValue)
    {
    case 1:
        return new VibrationPattern_1();
    case 2:
        return new VibrationPattern_2();
    case 3:
        return new VibrationPattern_3();
    case 4:
        return new VibrationPattern_4();
    case 5:
        return new VibrationPattern_5();
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
    case 2:
        return new SoundPattern_2();
    case 3:
        return new SoundPattern_3();
    case 4:
        return new SoundPattern_4();
    case 5:
        return new SoundPattern_5();
    default:
        return nullptr;
    }
}
