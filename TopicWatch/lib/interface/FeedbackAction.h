#ifndef FEEDBACK_ACTION_INTERFACE
#define FEEDBACK_ACTION_INTERFACE

class FeedbackAction
{
public:
    virtual void start(int pin) = 0;
    virtual void update() = 0;
    virtual void cancel() = 0;
    virtual bool isFinished() = 0;
};

#endif