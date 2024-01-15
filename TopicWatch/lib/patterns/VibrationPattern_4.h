#ifndef VIBRATION_PATTERN_4
#define VIBRATION_PATTERN_4

#include "VibrationFeedbackPattern.h"
#include "VibrateAction.h"
#include "WaitAction.h"

class VibrationPattern_4 : public VibrationFeedbackPattern
{
private:
    static const int _amountOfActions = 3;
    FeedbackAction *_actions[_amountOfActions] = {
        new VibrateAction(250),
        new WaitAction(250),
        new VibrateAction(250)};
    int _currentActionIndex;
    bool _patternStarted;
    bool _isPlaying = false;

public:
    VibrationPattern_4() : _currentActionIndex(0), _patternStarted(false){};
    ~VibrationPattern_4();
    bool start() override;
    void update() override;
    void cancel() override;
    bool isFinished() override;
};

#endif