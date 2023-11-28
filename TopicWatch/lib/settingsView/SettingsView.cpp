#include "SettingsView.h"

void SettingsView::_clearCenter()
{
    _tft->fillRect(WatchSettings::borderSize, WatchSettings::borderSize, (_tft->width() - (2 * WatchSettings::borderSize)), (_tft->height() - (2 * WatchSettings::borderSize)), WatchSettings::topicTimer_BLACK);
}

void SettingsView::init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider, int *hasBluetoothConnnection, int *amountOfActiveViews, int *currentViewIndex)
{
    _tft = tft;
    _border = border;
    _vRTCProvider = vRTCProvider;
    _hasBluetoothConnnection = hasBluetoothConnnection;
}

void SettingsView::draw(int clearScreen)
{
    if (clearScreen)
    {
        _clearCenter();
    }
}

ViewTypes SettingsView::getViewType() const
{
    return ViewTypes::SETTINGS;
}