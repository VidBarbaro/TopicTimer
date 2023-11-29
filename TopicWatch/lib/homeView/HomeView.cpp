#include "HomeView.h"

void HomeView::_clearCenter()
{
    _tft->fillRect(WatchSettings::borderSize, WatchSettings::borderSize, (_tft->width() - (2 * WatchSettings::borderSize)), (_tft->height() - (2 * WatchSettings::borderSize)), WatchSettings::topicTimer_BLACK);
}

void HomeView::_setClickableItems()
{
    _items[0].type = ClickableItemType::GO_TO_SETTINGS;
    _items[0].x = (WatchSettings::borderSize + WatchSettings::marginFromBorder);
    _items[0].y = _tft->height() - (WatchSettings::borderSize + WatchSettings::marginFromBorder + WatchSettings::iconSize);
    _items[0].width = WatchSettings::iconSize;
    _items[0].height = WatchSettings::iconSize;
}

void HomeView::init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider, int *hasBluetoothConnnection, int *amountOfActiveViews, int *currentViewIndex)
{
    _tft = tft;
    _border = border;
    _vRTCProvider = vRTCProvider;
    _dateTime = _vRTCProvider->getTime();
    _hasBluetoothConnnection = hasBluetoothConnnection;

    _setClickableItems();
}

void HomeView::draw(int clearScreen)
{
    if (clearScreen)
    {
        _clearCenter();
    }

    _tft->setTextSize(6);
    _tft->setTextDatum(MC_DATUM);
    _tft->drawString(StringHelper::padZeroLeft(String(_dateTime->hours)) + ':' + StringHelper::padZeroLeft(String(_dateTime->minutes)), _tft->width() / 2, _tft->height() / 2);

    _tft->setTextSize(2);
    _tft->setTextDatum(BC_DATUM);
    _tft->drawString(StringHelper::padZeroLeft(String(_dateTime->day)) + '-' + StringHelper::padZeroLeft(String(_dateTime->month)) + '-' + StringHelper::padZeroLeft(String(_dateTime->year)),
                     _tft->width() / 2,
                     _tft->height() - (WatchSettings::borderSize + WatchSettings::marginFromBorder));

    _border->set(100, WatchSettings::topicTimer_BLACK);

    _tft->setSwapBytes(true);
    _tft->pushImage((WatchSettings::borderSize + WatchSettings::marginFromBorder),
                    _tft->height() - (WatchSettings::borderSize + WatchSettings::marginFromBorder + (WatchSettings::iconSize * 2) + WatchSettings::iconMargin),
                    WatchSettings::iconSize, WatchSettings::iconSize,
                    *_hasBluetoothConnnection ? Bluetooth : NoBluetooth,
                    TFT_PINK);
    _tft->pushImage((WatchSettings::borderSize + WatchSettings::marginFromBorder),
                    _tft->height() - (WatchSettings::borderSize + WatchSettings::marginFromBorder + WatchSettings::iconSize),
                    WatchSettings::iconSize, WatchSettings::iconSize,
                    Settings,
                    TFT_PINK);
    _tft->setSwapBytes(false);
}

ViewTypes HomeView::getViewType() const
{
    return ViewTypes::HOME;
}

ClickableItem *HomeView::getListOfClickableItems(int *arraySize)
{
    *arraySize = sizeof(_items) / sizeof(_items[0]);
    return &_items[0];
}