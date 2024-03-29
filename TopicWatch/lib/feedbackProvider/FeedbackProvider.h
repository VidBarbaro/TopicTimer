#ifndef FEEDBACK_PROVIDER
#define FEEDBACK_PROVIDER

#include "VibrationFeedbackPattern.h"
#include "SoundFeedbackPattern.h"

class FeedbackProvider
{
private:
    static FeedbackPattern *_currentPattern;
    static VibrationFeedbackPattern *_vibrationPattern;
    static SoundFeedbackPattern *_soundPattern;

    static void cancel(FeedbackPattern *&pattern);
    static void cancel(VibrationFeedbackPattern *&pattern);
    static void cancel(SoundFeedbackPattern *&pattern);

public:
    FeedbackProvider() = delete;

    static void setVibrationPattern(VibrationFeedbackPattern *pattern = nullptr);
    static void setSoundPattern(SoundFeedbackPattern *pattern = nullptr);
    static void playPattern();
    static void playPattern(FeedbackPattern *pattern);
    static void update();
    static void cancel();
};

#endif