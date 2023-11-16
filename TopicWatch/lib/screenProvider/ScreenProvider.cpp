#include "ScreenProvider.h"

void *ScreenProvider::_instance = nullptr;

void ScreenProvider::onGesture(CST816Touch *pTouch, String iGestureId, bool bReleasedScreen)
{
    if (_instance == nullptr)
    {
        return;
    }

    ScreenProvider *instance = (ScreenProvider *)_instance;
    instance->_border.set(100, TFT_BLUE);
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

    _border.init(&_tft, 3);
    _vRTCProvider = vRTCProvider;
    _dateTime = _vRTCProvider->getTime();

    /*
     * Turn on and initialize the screen
     */
    pinMode(PIN_POWER_ON, OUTPUT);
    digitalWrite(PIN_POWER_ON, HIGH);

    _tft.begin();
    _tft.setRotation(1);
    _tft.fillScreen(TFT_BLACK);

    /*
     * Print initial border
     */
    _border.set(100, TFT_RED);

    _tft.setTextSize(5);
    _tft.setTextDatum(MC_DATUM);

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

    String s = StringHelper::padZeroLeft(String(_dateTime->hours)) + ':' + StringHelper::padZeroLeft(String(_dateTime->minutes)) + ':' + StringHelper::padZeroLeft(String(_dateTime->seconds));
    _tft.drawString(s, _tft.width() / 2, _tft.height() / 2);
}