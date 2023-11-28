#ifndef VIEW_INTERFACE
#define VIEW_INTERFACE

#include "Arduino.h"
#include "Border.h"
#include "BluetoothIcon.h"
#include "NoBluetoothIcon.h"
#include "SettingsIcon.h"
#include "StringHelper.h"
#include "TFT_eSPI.h"
#include "VirtualRTCProvider.h"
#include "WatchSettings.h"

enum ViewTypes
{
    NONE,
    HOME,
    TOPIC,
    SETTINGS
};

class View
{
public:
    // IDK HOW THIS WORKS WITH INTERFACES, ONCE I FIGURE THAT OUT I'LL UPDATE THIS
    virtual void init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider, int *hasBluetoothConnnection, int *amountOfActiveViews = nullptr, int *currentViewIndex = nullptr) = 0;
    virtual void draw(int clearScreen = false) = 0;
    virtual ViewTypes getViewType() const { return ViewTypes::NONE; };
};

#endif