#include "PatternFactory.h"

FeedbackPattern *PatternFactory::createPattern(int patternValue, PatternTypes patternType)
{
    switch (patternType)
    {
    case VIBRATION:
        switch (patternValue)
        {
        case 1:
            return new VibrationPattern_1();
        // case 2:
        //     return new VibrationPattern_2();
        default:
            return nullptr;
        }
    case SOUND:
        switch (patternValue)
        {
        // case 1:
        //     return new SoundPattern_1();
        // case 2:
        //     return new SoundPattern_2();
        default:
            return nullptr;
        }
    default:
        return nullptr;
    }
}