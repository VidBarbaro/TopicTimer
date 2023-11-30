#include "SettingsView.h"

void SettingsView::_clearCenter()
{
    _tft->fillRect(WatchSettings::get<int>(borderSize), WatchSettings::get<int>(borderSize), (_tft->width() - (2 * WatchSettings::get<int>(borderSize))), (_tft->height() - (2 * WatchSettings::get<int>(borderSize))), WatchSettings::get<uint16_t>(topicTimer_BLACK));
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

    _border->set(100, WatchSettings::get<uint16_t>(topicTimer_BLACK));

    for (int i = 0; i < _amountOfSettingsPerPage; i++)
    {
        WatchSetting ws = _editableSettings[i + (_amountOfSettingsPerPage * _verticalPageIndex)];

        if (ws.displayName != "")
        {
            _tft->setTextSize(2);
            _tft->setTextDatum(ML_DATUM);
            _tft->drawString(ws.displayName, WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder), WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder) + (_settingsHeight / 3));
        }

        if (i != _amountOfSettingsPerPage - 1)
        {
            _tft->fillRect(WatchSettings::get<int>(borderSize), _settingsHeight * (i + 1), WatchSettings::get<int>(screenHorizontal) - (WatchSettings::get<int>(borderSize) * 2), 1, WatchSettings::get<uint16_t>(topicTimer_GRAY));
        }
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