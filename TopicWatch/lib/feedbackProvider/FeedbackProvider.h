#ifndef FEEDBACK_PROVIDER
#define FEEDBACK_PROVIDER

#include "FeedbackPattern.h"
#include "VibrationPattern_1.h"
#include "VibrateAction.h"
#include "BuzzAction.h"
#include "WaitAction.h"

class FeedbackProvider
{
private:
    static FeedbackPattern *_currentPattern;

public:
    FeedbackProvider() = delete;

    static void playPattern(FeedbackPattern *pattern);
    static void update();
    static void cancel();
};

#endif