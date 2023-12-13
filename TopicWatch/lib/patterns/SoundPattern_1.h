#ifndef SOUND_PATTERN_1
#define SOUND_PATTERN_1

#include "FeedbackPattern.h"
#include "BuzzAction.h"
#include "WaitAction.h"

class SoundPattern_1 : public FeedbackPattern
{
private:
    static const int _amountOfActions = 6;
    FeedbackAction *_actions[_amountOfActions] = {
        new BuzzAction(250),
        new WaitAction(250),
        new BuzzAction(250),
        new WaitAction(250),
        new BuzzAction(750),
        new WaitAction(0)};
    int _currentActionIndex;
    bool _patternStarted;

public:
    SoundPattern_1() : _currentActionIndex(0), _patternStarted(false){};
    ~SoundPattern_1();
    bool start() override;
    void update() override;
    void cancel() override;
    bool isFinished() const override;
};

#endif