#ifndef FEEDBACK_PATTERN_INTERFACE
#define FEEDBACK_PATTERN_INTERFACE

class FeedbackPattern
{
public:
    virtual bool start() = 0;
    virtual void update() = 0;
    virtual void cancel() = 0;
    virtual bool isFinished() = 0;
};

#endif