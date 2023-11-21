#ifndef TouchSubscriber_H
#define TouchSubscriber_H

#include "Arduino.h"
#include "TouchSubscriberInterface.h"

namespace MDO
{
    typedef void (*GestureCallback)(CST816Touch *pTouch, int iGestureId, bool bReleasedScreen);
    typedef void (*TouchCallback)(CST816Touch *pTouch, int x, int y, bool bReleasedScreen);
    class TouchSubscriber : public TouchSubscriberInterface
    {
    private:
        GestureCallback _gestureCallback;
        TouchCallback _touchCallback;

    public:
        // the pointer is the 'this' from the CST816Touch source
        virtual void gestureNotification(CST816Touch *pTouch, int iGestureId, bool bReleasedScreen);
        virtual void setGestureCallback(void (*func)(CST816Touch *pTouch, int iGestureId, bool bReleasedScreen));

        // the pointer is the 'this' from the CST816Touch source
        virtual void touchNotification(CST816Touch *pTouch, int x, int y, bool bReleasedScreen);
        virtual void setTouchCallback(void (*func)(CST816Touch *pTouch, int x, int y, bool bReleasedScreen));
        TouchSubscriber();
        virtual ~TouchSubscriber();
    };

} // namespace end

#endif