#ifndef PATTERN_FACTORY
#define PATTERN_FACTORY

#include "FeedbackPattern.h"
#include "VibrationPattern_1.h"

enum PatternTypes
{
    VIBRATION,
    SOUND
};

class PatternFactory
{
public:
    static FeedbackPattern *createPattern(int patternValue, PatternTypes patternType);
};

#endif