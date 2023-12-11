#ifndef TRACKING_INFO
#define TRACKING_INFO

#include <WString.h>

struct DateTime
{
    int hours = 0;
    int minutes = 0;
    int seconds = 0;
    int year = 0;
    int month = 0;
    int day = 0;
};

struct TrackingInfo
{
    String topicId;
    DateTime startTime;
    DateTime endTime;
};

#endif