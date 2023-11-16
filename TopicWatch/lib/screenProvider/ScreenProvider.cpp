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
        instance->_border.set(100, TFT_BLUE);
        break;
    case CST816Touch::gesture_t::GESTURE_RIGHT:
        instance->_border.set(100, TFT_BROWN);
        break;
    case CST816Touch::gesture_t::GESTURE_DOWN:
        instance->_border.set(100, TFT_COLMOD);
        break;
    case CST816Touch::gesture_t::GESTURE_LEFT:
        instance->_border.set(100, 0xFFFF00);
        break;
    case CST816Touch::gesture_t::GESTURE_DOUBLE_CLICK:
        instance->_border.set(100, 0xFFC0CB);
        break;
    case CST816Touch::gesture_t::GESTURE_LONG_PRESS:
        instance->_border.set(100, 0xFF5A00);
        break;
    case CST816Touch::gesture_t::GESTURE_TOUCH_BUTTON:
        instance->_border.set(100, 0x800080);
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
    instance->_border.set(100, TFT_GREEN);
}

void ScreenProvider::init(VirtualRTCProvider *vRTCProvider)
{
    _instance = this;

    _border.init(&_tft, 4);
    _vRTCProvider = vRTCProvider;
    _dateTime = _vRTCProvider->getTime();

    /*
     * Turn on and initialize the screen
     */
    pinMode(PIN_POWER_ON, OUTPUT);
    digitalWrite(PIN_POWER_ON, HIGH);

    _tft.begin();
    _tft.setRotation(1);
    _tft.fillScreen(TT_GRAY);
    _tft.setTextColor(TT_BLACK, TT_GRAY);

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

    _tft.setTextSize(5);
    _tft.setTextDatum(MC_DATUM);
    String s = StringHelper::padZeroLeft(String(_dateTime->hours)) + ':' + StringHelper::padZeroLeft(String(_dateTime->minutes));
    _tft.drawString(s, _tft.width() / 2, _tft.height() / 2);
}