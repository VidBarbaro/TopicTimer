#ifndef PATTERN_FACTORY
#define PATTERN_FACTORY

#include "VibrationFeedbackPattern.h"
#include "SoundFeedbackPattern.h"

#include "VibrationPattern_1.h"
#include "VibrationPattern_2.h"

#include "SoundPattern_1.h"

class PatternFactory
{
public:
    static VibrationFeedbackPattern *createVibrationPattern(int patternValue);
    static SoundFeedbackPattern *createSoundPattern(int patternValue);
};

#endif