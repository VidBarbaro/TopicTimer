#include "TouchSubscriber.h"
#include "CST816Touch.h"

namespace MDO
{

    // the pointer is the 'this' from the CST816Touch source
    /*virtual*/ void TouchSubscriber::gestureNotification(CST816Touch *pTouch, int iGestureId, bool bReleasedScreen)
    {
        Serial.print("Gesture");
        if (bReleasedScreen)
        {
            Serial.print(" release");
        }
        Serial.print(" detected: ");
        Serial.print(CST816Touch::gestureIdToString(iGestureId));

        if ((pTouch != 0) && ((iGestureId == (int)CST816Touch::gesture_t::GESTURE_LONG_PRESS) ||
                              (iGestureId == (int)CST816Touch::gesture_t::GESTURE_DOUBLE_CLICK)))
        {
            int x = 0;
            int y = 0;
            CST816Touch::gesture_t eGesture;

            pTouch->getLastGesture(eGesture, x, y);

            Serial.print(" at: (");
            Serial.print(x);
            Serial.print(",");
            Serial.print(y);
            Serial.print(")");
        }

        Serial.println();
        _gestureCallback(pTouch, iGestureId, bReleasedScreen);
    }

    /*virtual*/ void TouchSubscriber::setGestureCallback(void (*func)(CST816Touch *pTouch, int iGestureId, bool bReleasedScreen))
    {
        _gestureCallback = func;
    }

    // the pointer is the 'this' from the CST816Touch source
    /*virtual*/ void TouchSubscriber::touchNotification(CST816Touch *pTouch, int x, int y, bool bReleasedScreen)
    {
        y = map(y, 0, WatchSettings::get<int>(String("screenVertical")), WatchSettings::get<int>(String("screenVertical")), 0); // invert the y
        Serial.println("Gesture TOUCH detected at x: " + String(x) + ", y: " + String(y));
        _touchCallback(pTouch, x, y, bReleasedScreen);
    }

    /*virtual*/ void TouchSubscriber::setTouchCallback(void (*func)(CST816Touch *pTouch, int x, int y, bool bReleasedScreen))
    {
        _touchCallback = func;
    }

    TouchSubscriber::TouchSubscriber()
    {
    }

    TouchSubscriber::~TouchSubscriber()
    {
    }

} // namespace end