#ifndef BUZZ_ACTION
#define BUZZ_ACTION

#include "FeedbackAction.h"

class BuzzAction : public FeedbackAction
{
private:
    Pwm _pwm;
    unsigned long _duration, _startTime;

public:
    BuzzAction(unsigned long duration) : _duration(duration), _startTime(0){};
    void start(int pin) override;
    void update() override;
    bool isFinished() const override;
    ~BuzzAction() = default;
};

#endif