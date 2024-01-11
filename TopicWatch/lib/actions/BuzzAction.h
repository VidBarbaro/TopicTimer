#ifndef BUZZ_ACTION
#define BUZZ_ACTION

#include <analogWrite.h>
#include "WatchSettings.h"
#include "FeedbackAction.h"

class BuzzAction : public FeedbackAction
{
private:
    int _pin;
    unsigned long _duration, _startTime;

public:
    BuzzAction(unsigned long duration) : _duration(duration), _startTime(0){};
    void start(int pin) override;
    void update() override;
    void cancel() override;
    bool isFinished() override;
    ~BuzzAction() = default;
};

#endif