#ifndef VIEW_INTERFACE
#define VIEW_INTERFACE

#include "Arduino.h"
#include "Border.h"
#include "BluetoothIcon.h"
#include "BluetoothIconSmall.h"
#include "NoBluetoothIcon.h"
#include "NoBluetoothIconSmall.h"
#include "SettingsIcon.h"
#include "StringHelper.h"
#include "TFT_eSPI.h"
#include "VirtualRTCProvider.h"
#include "WatchSettings.h"
#include "FeedbackProvider.h"
#include "PatternFactory.h"

#include "NotoSansBold15.h"
#include "NotoSansBold36.h"
#include "NotoSansBold56.h"

#define AA_FONT_SMALL NotoSansBold15
#define AA_FONT_BIG NotoSansBold36
#define AA_FONT_BIGGEST NotoSansBold56

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
    virtual int getViewState() const { return 0; };
    virtual ClickableItem *getListOfClickableItems(int *arraySize) = 0;
};

#endif