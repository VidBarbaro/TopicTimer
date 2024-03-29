#ifndef SOUND_PATTERN_5
#define SOUND_PATTERN_5

#include "SoundFeedbackPattern.h"
#include "BuzzAction.h"
#include "WaitAction.h"

class SoundPattern_5 : public SoundFeedbackPattern
{
private:
    static const int _amountOfActions = 1;
    FeedbackAction *_actions[_amountOfActions] = {
        new BuzzAction(500)};
    int _currentActionIndex;
    bool _patternStarted;
    bool _isPlaying = false;

public:
    SoundPattern_5() : _currentActionIndex(0), _patternStarted(false){};
    ~SoundPattern_5();
    bool start() override;
    void update() override;
    void cancel() override;
    bool isFinished() override;
};

#endif