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
        instance->_viewController.nextDown();
        break;
    case CST816Touch::gesture_t::GESTURE_RIGHT:
        instance->_viewController.nextLeft();
        break;
    case CST816Touch::gesture_t::GESTURE_DOWN:
        instance->_viewController.nextUp();
        break;
    case CST816Touch::gesture_t::GESTURE_LEFT:
        instance->_viewController.nextRight();
        break;
    case CST816Touch::gesture_t::GESTURE_DOUBLE_CLICK:
        switch (instance->_viewController.getCurrentViewType())
        {
        case ViewTypes::TOPIC:
            if (instance->_viewController.getCurrentViewState())
            {
                instance->_viewController.stopTracking();
            }
            else
            {
                instance->_viewController.startTracking();
            }
            break;
        case ViewTypes::SETTINGS:
            if (instance->_viewController.getCurrentViewState())
            {
                instance->_viewController.stopEditing();
            }
            break;
        default:
            break;
        }

        break;
    case CST816Touch::gesture_t::GESTURE_LONG_PRESS:
        instance->_viewController.togglePauseTracking(); // THIS IS MAYBE TOO LONG, MAYBE CHANGE THE EVENT FOR THIS
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
    instance->_viewController.click(x, y);
}

void ScreenProvider::init(VirtualRTCProvider *vRTCProvider, BLEProvider *bleProvider)
{
    _instance = this;

    _border.init(&_tft);
    _bleProvider = bleProvider;
    _vRTCProvider = vRTCProvider;

    /*
     * Turn on and initialize the screen
     */
    pinMode(PIN_POWER_ON, OUTPUT);
    digitalWrite(PIN_POWER_ON, HIGH);

    _tft.begin();
    _tft.setRotation(1);
    _tft.fillScreen(WatchSettings::get<uint16_t>(topicTimer_BLACK));
    _tft.setTextColor(WatchSettings::get<uint16_t>(topicTimer_GRAY), WatchSettings::get<uint16_t>(topicTimer_BLACK), true);

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

    /*
     * Setup ViewController
     */
    _viewController.init(&_tft, &_border, _vRTCProvider);
}

void ScreenProvider::setVirtualRTCProviderTime(int hours, int minutes, int seconds, int year, int month, int day)
{
    _vRTCProvider->setTime(hours, minutes, seconds, year, month, day);
}

void ScreenProvider::setHasBluetoothConnection()
{
    Serial.println("ScreenProvider: setHasBluetoothConnection()");
    _viewController.setHasBluetoothConnection();
}

void ScreenProvider::setHasNoBluetoothConnection()
{
    Serial.println("ScreenProvider: setHasNoBluetoothConnection()");
    _viewController.setHasNoBluetoothConnection();
}

void ScreenProvider::update()
{
    _touch.control();
    int bleConnectionState = _bleProvider->getConnectionState();
    if (bleConnectionState > -1)
    {
        bleConnectionState ? _viewController.setHasBluetoothConnection() : _viewController.setHasNoBluetoothConnection();
    }
    _viewController.drawCurrentView();
}