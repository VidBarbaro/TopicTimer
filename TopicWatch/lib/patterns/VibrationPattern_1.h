#ifndef VIBRATION_PATTERN_1
#define VIBRATION_PATTERN_1

#include "VibrationFeedbackPattern.h"
#include "VibrateAction.h"
#include "WaitAction.h"

class VibrationPattern_1 : public VibrationFeedbackPattern
{
private:
    static const int _amountOfActions = 6;
    FeedbackAction *_actions[_amountOfActions] = {
        new VibrateAction(250),
        new WaitAction(250),
        new VibrateAction(250),
        new WaitAction(250),
        new VibrateAction(750),
        new WaitAction(0)};
    int _currentActionIndex;
    bool _patternStarted;
    bool _isPlaying = false;

public:
    VibrationPattern_1() : _currentActionIndex(0), _patternStarted(false){};
    ~VibrationPattern_1();
    bool start() override;
    void update() override;
    void cancel() override;
    bool isFinished() override;
};

#endif