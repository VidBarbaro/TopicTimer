#include "TrackInfoBuffer.h"

std::list<TrackingInfo> TrackInfoBuffer::trackData;
int TrackInfoBuffer::trackDataCounter = 0;

TrackInfoBuffer::TrackInfoBuffer(void)
{
}

TrackInfoBuffer::~TrackInfoBuffer(void)
{
}

bool TrackInfoBuffer::add(TrackingInfo *newInfo)
{
    if (newInfo != nullptr)
    {
        trackData.push_back(*newInfo);
        trackDataCounter++;

        return true;
    }
    return false;
}

bool TrackInfoBuffer::add(DateTime *beginTime, DateTime *endTime, String id)
{
    if (beginTime != nullptr || endTime != nullptr || !id.isEmpty())
    {
        TrackingInfo newData;
        newData.startTime = *beginTime;
        newData.endTime = *endTime;
        newData.topicId = id;
        trackData.push_back(newData);
        trackDataCounter++;

        return true;
    }
    return false;
}

TrackingInfo *TrackInfoBuffer::consume(bool removeItem)
{
    if (trackDataCounter == 0)
    {
        return nullptr;
    }

    static TrackingInfo info;
    info = trackData.front();

    if (removeItem)
    {
        trackData.pop_front();
        trackDataCounter--;
    }
    return &info;
}

int TrackInfoBuffer::getCount()
{
    if (trackDataCounter > 0)
    {
        Serial.println("Counter is more than zero");
    }
    return trackDataCounter;
}

bool TrackInfoBuffer::isEmpty()
{
    return trackDataCounter == 0 ? true : false;
}
bool TrackInfoBuffer::reset()
{
    trackData.clear();
    return true;
}