#include "ScreenProvider.h"

void *ScreenProvider::_instance = nullptr;

void ScreenProvider::onGesture(CST816Touch *pTouch, int iGestureId, bool bReleasedScreen)
{
    if (_instance == nullptr)
    {
        return;
    }

    ScreenProvider *instance = (ScreenProvider *)_instance;
    switch (iGestureId)
    {
    case CST816Touch::gesture_t::GESTURE_UP:
        // Nothing for now
        break;
    case CST816Touch::gesture_t::GESTURE_RIGHT:
        instance->_viewController.nextLeft();
        break;
    case CST816Touch::gesture_t::GESTURE_DOWN:
        // Nothing for now
        break;
    case CST816Touch::gesture_t::GESTURE_LEFT:
        instance->_viewController.nextRight();
        break;
    case CST816Touch::gesture_t::GESTURE_DOUBLE_CLICK:
        if (instance->_viewController.getCurrentViewState())
        {
            instance->_viewController.stopTracking();
        }
        else
        {
            instance->_viewController.startTracking();
        }

        break;
    case CST816Touch::gesture_t::GESTURE_LONG_PRESS:
        // Nothing for now
        break;
    case CST816Touch::gesture_t::GESTURE_TOUCH_BUTTON:
        instance->_viewController.home();
        break;
    default:
        break;
    }
}

void ScreenProvider::onTouch(CST816Touch *pTouch, int x, int y, bool bReleasedScreen)
{
    if (_instance == nullptr)
    {
        return;
    }

    ScreenProvider *instance = (ScreenProvider *)_instance;
    // Nothing for now
}

void ScreenProvider::init(VirtualRTCProvider *vRTCProvider)
{
    _instance = this;

    _border.init(&_tft, 4);
    _vRTCProvider = vRTCProvider;
    _viewController.init(&_tft, &_border, _vRTCProvider);
    Topic tmpTopic;
    tmpTopic.id = 0;
    tmpTopic.name = "Tycho's test topic";
    tmpTopic.color = 0x89CFF0;
    _viewController.addView(tmpTopic);
    Topic tmpTopic2;
    tmpTopic2.id = 1;
    tmpTopic2.name = "Tycho's 2nd test topic";
    tmpTopic2.color = TFT_RED;
    _viewController.addView(tmpTopic2);

    /*
     * Turn on and initialize the screen
     */
    pinMode(PIN_POWER_ON, OUTPUT);
    digitalWrite(PIN_POWER_ON, HIGH);

    _tft.begin();
    _tft.setRotation(1);
    _tft.fillScreen(WatchSettings::topicTimer_GRAY);
    _tft.setTextColor(WatchSettings::topicTimer_BLACK, WatchSettings::topicTimer_GRAY);

    /*
     * Setup touchscreen
     */
    _touchSubscriber.setGestureCallback(onGesture);
    _touchSubscriber.setTouchCallback(onTouch);

    Wire.begin(PIN_IIC_SDA, PIN_IIC_SCL);
    Wire.setClock(400000);

    if (!_touch.begin(Wire, &_touchSubscriber))
    {
        Serial.println("Touch screen initialization failed..");
    };
    _touch.setOperatingModeFast();
    _touch.setAutoSleep(false);

    CST816Touch::device_type_t eDeviceType;
    if (_touch.getDeviceType(eDeviceType))
    {
        Serial.print("Device is of type: ");
        Serial.println(CST816Touch::deviceTypeToString(eDeviceType));
    }

    Serial.println("Touch screen initialization done");
}

void ScreenProvider::setVirtualRTCProviderTime(int hours, int minutes, int seconds, int year, int month, int day)
{
    _vRTCProvider->setTime(hours, minutes, seconds, year, month, day);
}

void ScreenProvider::update()
{
    _touch.control();
    _viewController.drawCurrentView();
}