#ifndef SOUND_PATTERN_4
#define SOUND_PATTERN_4

#include "SoundFeedbackPattern.h"
#include "BuzzAction.h"
#include "WaitAction.h"

class SoundPattern_4 : public SoundFeedbackPattern
{
private:
    static const int _amountOfActions = 3;
    FeedbackAction *_actions[_amountOfActions] = {
        new BuzzAction(250),
        new WaitAction(250),
        new BuzzAction(250)};
    int _currentActionIndex;
    bool _patternStarted;
    bool _isPlaying = false;

public:
    SoundPattern_4() : _currentActionIndex(0), _patternStarted(false){};
    ~SoundPattern_4();
    bool start() override;
    void update() override;
    void cancel() override;
    bool isFinished() override;
};

#endif