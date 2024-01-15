#ifndef VIBRATION_PATTERN_5
#define VIBRATION_PATTERN_5

#include "VibrationFeedbackPattern.h"
#include "VibrateAction.h"
#include "WaitAction.h"

class VibrationPattern_5 : public VibrationFeedbackPattern
{
private:
    static const int _amountOfActions = 1;
    FeedbackAction *_actions[_amountOfActions] = {
        new VibrateAction(500)};
    int _currentActionIndex;
    bool _patternStarted;
    bool _isPlaying = false;

public:
    VibrationPattern_5() : _currentActionIndex(0), _patternStarted(false){};
    ~VibrationPattern_5();
    bool start() override;
    void update() override;
    void cancel() override;
    bool isFinished() override;
};

#endif