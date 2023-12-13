#ifndef FEEDBACK_PATTERN_INTERFACE
#define FEEDBACK_PATTERN_INTERFACE

#include "WatchSettings.h"

class FeedbackPattern
{
public:
    virtual bool start() = 0;
    virtual void update() = 0;
    virtual void cancel() = 0;
    virtual bool isFinished() const = 0;
};

#endif