#include "SettingsView.h"

void SettingsView::_clearCenter()
{
    _tft->fillRect(WatchSettings::get<int>(String("borderSize")), WatchSettings::get<int>(String("borderSize")), (_tft->width() - (2 * WatchSettings::get<int>(String("borderSize")))), (_tft->height() - (2 * WatchSettings::get<int>(String("borderSize")))), WatchSettings::get<uint16_t>(String("topicTimer_BLACK")));
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

    _border->set(100, WatchSettings::get<uint16_t>(String("topicTimer_BLACK")));

    for (int i = 0; i < _amountOfSettingsPerPage - 1; i++)
    {
        _tft->setTextSize(2);
        _tft->fillRect(WatchSettings::get<int>(String("borderSize")), _settingsHeight * (i + 1), WatchSettings::get<int>(String("screenHorizontal")) - (WatchSettings::get<int>(String("borderSize")) * 2), 1, WatchSettings::get<uint16_t>(String("topicTimer_GREEN")));
    }
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