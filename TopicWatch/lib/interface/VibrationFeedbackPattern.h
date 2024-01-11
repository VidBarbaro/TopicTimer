#ifndef VIBRATION_FEEDBACK_PATTERN_INTERFACE
#define VIBRATION_FEEDBACK_PATTERN_INTERFACE

#include "FeedbackPattern.h"

class VibrationFeedbackPattern : public FeedbackPattern
{
public:
    virtual bool start() override = 0;
    virtual void update() override = 0;
    virtual void cancel() override = 0;
    virtual bool isFinished() override = 0;
};

#endif