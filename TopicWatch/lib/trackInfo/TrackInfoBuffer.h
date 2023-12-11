#ifndef TRACK_INFO_BUFFER
#define TRACK_INFO_BUFFER

// This class is responsible for saving the tracking data

#include <list>
#include "TrackingInfo.h" //Contains TrackingInfo struct
#include <WString.h>
#include <Arduino.h>

class TrackInfoBuffer
{
private:
    static int trackDataCounter;
    static std::list<TrackingInfo> trackData;

public:
    TrackInfoBuffer(void);
    ~TrackInfoBuffer(void);

    bool add(TrackingInfo *newInfo);
    bool add(DateTime *beginTime, DateTime *endTime, String id);

    TrackingInfo *consume(bool removeItem = true);
    int getCount(void);
    bool isEmpty(void);
    bool reset(void);
};

static TrackInfoBuffer trackedTimesBuffer;

#endif