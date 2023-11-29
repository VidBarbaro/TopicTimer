#include "SettingsView.h"

void SettingsView::_clearCenter()
{
    _tft->fillRect(WatchSettings::borderSize, WatchSettings::borderSize, (_tft->width() - (2 * WatchSettings::borderSize)), (_tft->height() - (2 * WatchSettings::borderSize)), WatchSettings::topicTimer_BLACK);
}

void SettingsView::_setClickableItems()
{
}

void SettingsView::init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider, int *hasBluetoothConnnection, int *amountOfActiveViews, int *currentViewIndex)
{
    _tft = tft;
    _border = border;
    _vRTCProvider = vRTCProvider;
    _hasBluetoothConnnection = hasBluetoothConnnection;

    _setClickableItems();
}

void SettingsView::draw(int clearScreen)
{
    if (clearScreen)
    {
        _clearCenter();
    }

    _border->set(100, WatchSettings::topicTimer_BLACK);
}

ViewTypes SettingsView::getViewType() const
{
    return ViewTypes::SETTINGS;
}

ClickableItem *SettingsView::getListOfClickableItems(int *arraySize)
{
    *arraySize = sizeof(_items) / sizeof(_items[0]);
    return &_items[0];
}