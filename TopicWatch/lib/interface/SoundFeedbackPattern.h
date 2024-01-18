#ifndef SOUND_FEEDBACK_PATTERN_INTERFACE
#define SOUND_FEEDBACK_PATTERN_INTERFACE

#include "FeedbackPattern.h"
// #include "BuzzAction.h"
// #include "WaitAction.h"

class SoundFeedbackPattern : public FeedbackPattern
{
public:
    virtual bool start() override = 0;
    virtual void update() override = 0;
    virtual void cancel() override = 0;
    virtual bool isFinished() override = 0;
};

#endif