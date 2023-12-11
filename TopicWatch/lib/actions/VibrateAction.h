#ifndef VIBRATION_ACTION
#define VIBRATION_ACTION

#include "FeedbackAction.h"

class VibrateAction : public FeedbackAction
{
private:
    Pwm _pwm;
    unsigned long _duration, _startTime;

public:
    VibrateAction(unsigned long duration) : _duration(duration), _startTime(0){};
    void start(int pin) override;
    void update() override;
    bool isFinished() const override;
    ~VibrateAction() = default;
};

#endif