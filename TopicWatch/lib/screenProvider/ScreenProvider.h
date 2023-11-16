#ifndef SCREEN_PROVIDER
#define SCREEN_PROVIDER

#include "Arduino.h"
#include "Border.h"
#include <CST816_TouchLib.h>
#include "PinConfig.h"
#include "StringHelper.h"
#include "TouchSubscriber.h"
#include "TFT_eSPI.h"
#include "VirtualRTCProvider.h"
#include <Wire.h>

#define TT_GRAY 0xF5F5F5
#define TT_BLACK 0x333333
#define TT_GREEN 0x009688
#define TT_ORANGE 0xFFC107
#define TT_BLUE 0x03A9F4

using namespace MDO;

class ScreenProvider
{

private:
    TFT_eSPI _tft = TFT_eSPI();
    Border _border;
    VirtualRTCProvider *_vRTCProvider;
    DateTime *_dateTime;
    TouchSubscriber _touchSubscriber;
    CST816Touch _touch;

    static void *_instance;
    static void onGesture(CST816Touch *pTouch, int iGestureId, bool bReleasedScreen);
    static void onTouch(CST816Touch *pTouch, int x, int y, bool bReleasedScreen);

public:
    ScreenProvider() = default;
    ~ScreenProvider() = default;
    void init(VirtualRTCProvider *vRTCProvider);
    void setVirtualRTCProviderTime(int hours, int minutes, int seconds, int year, int month, int day);
    void update();
};

#endif