#ifndef PATTERN_FACTORY
#define PATTERN_FACTORY

#include "VibrationPattern_1.h"
#include "VibrationPattern_2.h"
#include "VibrationPattern_3.h"
#include "VibrationPattern_4.h"
#include "VibrationPattern_5.h"

#include "SoundPattern_1.h"
#include "SoundPattern_2.h"
#include "SoundPattern_3.h"
#include "SoundPattern_4.h"
#include "SoundPattern_5.h"

class PatternFactory
{
public:
    static VibrationFeedbackPattern *createVibrationPattern(int patternValue);
    static SoundFeedbackPattern *createSoundPattern(int patternValue);
};

#endif