#ifndef FEEDBACK_PATTERN
#define FEEDBACK_PATTERN

#include "WatchSettings.h"
#include "VibrateAction.h"
#include "BuzzAction.h"
#include "WaitAction.h"

class FeedbackPattern
{
public:
    virtual void start() = 0;
    virtual void update() = 0;
    virtual bool isFinished() const = 0;
    ~FeedbackPattern();
};

#endif