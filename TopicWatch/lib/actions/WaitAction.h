#ifndef WAIT_ACTION
#define WAIT_ACTION

#include "WatchSettings.h"
#include "FeedbackAction.h"

class WaitAction : public FeedbackAction
{
private:
    int _pin;
    unsigned long _duration, _startTime;

public:
    WaitAction(unsigned long duration) : _duration(duration), _startTime(0){};
    void start(int pin) override;
    void update() override;
    void cancel() override;
    bool isFinished() override;
    ~WaitAction() = default;
};

#endif