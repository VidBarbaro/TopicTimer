#ifndef VIBRATION_PATTERN_1
#define VIBRATION_PATTERN_1

#include "FeedbackPattern.h"

class VibrationPattern_1 : public FeedbackPattern
{
private:
    static const int _amountOfActions = 6;
    FeedbackAction *_actions[_amountOfActions] = {
        new VibrateAction(500),
        new WaitAction(500),
        new VibrateAction(1000),
        new WaitAction(500),
        new VibrateAction(500),
        new WaitAction(0) // Last action, no waiting
    };
    int _currentActionIndex;
    bool _patternStarted;

public:
    VibrationPattern_1() : _currentActionIndex(0), _patternStarted(false){};
    void start() override;
    void update() override;
    bool isFinished() const override;
    ~VibrationPattern_1() = default;
};

#endif