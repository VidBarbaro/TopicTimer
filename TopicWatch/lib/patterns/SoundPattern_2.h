#ifndef SOUND_PATTERN_2
#define SOUND_PATTERN_2

#include "SoundFeedbackPattern.h"
#include "BuzzAction.h"
#include "WaitAction.h"

class SoundPattern_2 : public SoundFeedbackPattern
{
private:
    static const int _amountOfActions = 5;
    FeedbackAction *_actions[_amountOfActions] = {
        new BuzzAction(500),
        new WaitAction(250),
        new BuzzAction(500),
        new WaitAction(250),
        new BuzzAction(750)};
    int _currentActionIndex;
    bool _patternStarted;
    bool _isPlaying = false;

public:
    SoundPattern_2() : _currentActionIndex(0), _patternStarted(false){};
    ~SoundPattern_2();
    bool start() override;
    void update() override;
    void cancel() override;
    bool isFinished() override;
};

#endif