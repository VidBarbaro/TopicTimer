#ifndef BUZZ_ACTION
#define BUZZ_ACTION

#include "pwmWrite.h"
#include "WatchSettings.h"
#include "FeedbackAction.h"

class BuzzAction : public FeedbackAction
{
private:
    Pwm *_pwm;
    int _pin;
    unsigned long _duration, _startTime;

public:
    BuzzAction(unsigned long duration) : _duration(duration), _startTime(0){};
    void start(int pin, Pwm *pwm) override;
    void update() override;
    void cancel() override;
    bool isFinished() override;
    ~BuzzAction() = default;
};

#endif