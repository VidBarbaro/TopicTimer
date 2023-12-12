#ifndef VIBRATION_PATTERN_1
#define VIBRATION_PATTERN_1

#include "FeedbackPattern.h"
#include "VibrateAction.h"
#include "WaitAction.h"

class VibrationPattern_1 : public FeedbackPattern
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

public:
    VibrationPattern_1() : _currentActionIndex(0), _patternStarted(false){};
    void start() override;
    void update() override;
    void cancel() override;
    bool isFinished() const override;
    ~VibrationPattern_1() = default;
};

#endif