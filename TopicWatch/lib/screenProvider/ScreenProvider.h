#ifndef SCREEN_PROVIDER
#define SCREEN_PROVIDER

#include "Arduino.h"
#include "Border.h"
#include "BLEProvider.h"
#include <CST816_TouchLib.h>
#include "PinConfig.h"
#include "TouchSubscriber.h"
#include "TFT_eSPI.h"
#include "VirtualRTCProvider.h"
#include "ViewController.h"
#include "WatchSettings.h"
#include <Wire.h>

using namespace MDO;

class ScreenProvider
{

private:
    TFT_eSPI _tft = TFT_eSPI();
    Border _border;
    BLEProvider *_bleProvider;
    VirtualRTCProvider *_vRTCProvider;
    TouchSubscriber _touchSubscriber;
    CST816Touch _touch;
    ViewController _viewController;

    static void *_instance;
    static void onGesture(CST816Touch *pTouch, int iGestureId, bool bReleasedScreen);
    static void onTouch(CST816Touch *pTouch, int x, int y, bool bReleasedScreen);

public:
    ScreenProvider() = default;
    ~ScreenProvider() = default;
    void init(VirtualRTCProvider *vRTCProvider, BLEProvider *bleProvider);
    void setVirtualRTCProviderTime(int hours, int minutes, int seconds, int year, int month, int day);
    void setHasBluetoothConnection();
    void setHasNoBluetoothConnection();
    void update();
};

#endif