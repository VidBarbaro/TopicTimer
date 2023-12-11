#ifndef WAIT_ACTION
#define WAIT_ACTION

#include "FeedbackAction.h"

class WaitAction : public FeedbackAction
{
private:
    Pwm _pwm;
    unsigned long _duration, _startTime;

public:
    WaitAction(unsigned long duration) : _duration(duration), _startTime(0){};
    void start(int pin) override;
    void update() override;
    bool isFinished() const override;
    ~WaitAction() = default;
};

#endif