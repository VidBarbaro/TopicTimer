#ifndef VIBRATION_PATTERN_2
#define VIBRATION_PATTERN_2

#include "VibrationFeedbackPattern.h"
#include "VibrateAction.h"
#include "WaitAction.h"

class VibrationPattern_2 : public VibrationFeedbackPattern
{
private:
    static const int _amountOfActions = 5;
    FeedbackAction *_actions[_amountOfActions] = {
        new VibrateAction(500),
        new WaitAction(250),
        new VibrateAction(500),
        new WaitAction(250),
        new VibrateAction(750)};
    int _currentActionIndex;
    bool _patternStarted;
    bool _isPlaying = false;

public:
    VibrationPattern_2() : _currentActionIndex(0), _patternStarted(false){};
    ~VibrationPattern_2();
    bool start() override;
    void update() override;
    void cancel() override;
    bool isFinished() override;
};

#endif