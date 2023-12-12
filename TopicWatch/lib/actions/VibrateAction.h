#ifndef VIBRATION_ACTION
#define VIBRATION_ACTION

#include "pwmWrite.h"
#include "WatchSettings.h"
#include "FeedbackAction.h"

class VibrateAction : public FeedbackAction
{
private:
    Pwm* _pwm;
    int _pin;
    unsigned long _duration, _startTime;

public:
    VibrateAction(unsigned long duration) : _duration(duration), _startTime(0){};
    void start(int pin, Pwm *pwm) override;
    void update() override;
    void cancel() override;
    bool isFinished() override;
    ~VibrateAction() = default;
};

#endif