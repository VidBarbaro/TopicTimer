#ifndef SOUND_PATTERN_3
#define SOUND_PATTERN_3

#include "SoundFeedbackPattern.h"
#include "BuzzAction.h"
#include "WaitAction.h"

class SoundPattern_3 : public SoundFeedbackPattern
{
private:
    static const int _amountOfActions = 3;
    FeedbackAction *_actions[_amountOfActions] = {
        new BuzzAction(500),
        new WaitAction(250),
        new BuzzAction(500)};
    int _currentActionIndex;
    bool _patternStarted;
    bool _isPlaying = false;

public:
    SoundPattern_3() : _currentActionIndex(0), _patternStarted(false){};
    ~SoundPattern_3();
    bool start() override;
    void update() override;
    void cancel() override;
    bool isFinished() override;
};

#endif