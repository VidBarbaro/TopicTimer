#ifndef FEEDBACK_PROVIDER
#define FEEDBACK_PROVIDER

#include "FeedbackPattern.h"

class FeedbackProvider
{
private:
    static FeedbackPattern *_currentPattern;

public:
    FeedbackProvider() = delete;
    ~FeedbackProvider();

    static void playPattern(FeedbackPattern *pattern);
    static void update();
};

#endif