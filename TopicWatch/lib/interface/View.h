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

enum ClickableItemType
{
    GO_TO_SETTINGS,
    SETTING
};

struct ClickableItem
{
    ClickableItemType type = ClickableItemType::SETTING;
    int x = 0;
    int y = 0;
    int width = 0;
    int height = 0;
};

class View
{
public:
    virtual void init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider, int *hasBluetoothConnnection, int *amountOfActiveViews = nullptr, int *currentViewIndex = nullptr) = 0;
    virtual void draw(int clearScreen = false) = 0;
    virtual ViewTypes getViewType() const { return ViewTypes::NONE; };
    virtual ClickableItem *getListOfClickableItems(int *arraySize) = 0;
};

#endif