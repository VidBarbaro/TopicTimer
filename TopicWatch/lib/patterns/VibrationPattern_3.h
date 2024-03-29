#ifndef VIBRATION_PATTERN_3
#define VIBRATION_PATTERN_3

#include "VibrationFeedbackPattern.h"
#include "VibrateAction.h"
#include "WaitAction.h"

class VibrationPattern_3 : public VibrationFeedbackPattern
{
private:
    static const int _amountOfActions = 3;
    FeedbackAction *_actions[_amountOfActions] = {
        new VibrateAction(500),
        new WaitAction(250),
        new VibrateAction(500)};
    int _currentActionIndex;
    bool _patternStarted;
    bool _isPlaying = false;

public:
    VibrationPattern_3() : _currentActionIndex(0), _patternStarted(false){};
    ~VibrationPattern_3();
    bool start() override;
    void update() override;
    void cancel() override;
    bool isFinished() override;
};

#endif