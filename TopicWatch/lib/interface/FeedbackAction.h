#ifndef FEEDBACK_ACTION
#define FEEDBACK_ACTION

#include "pwmWrite.h"
#include "WatchSettings.h"

class FeedbackAction
{
public:
    virtual void start(int pin) = 0;
    virtual void update() = 0;
    virtual bool isFinished() const = 0;
    virtual ~FeedbackAction();
};

#endif