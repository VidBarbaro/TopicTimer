#include "HomeView.h"

void HomeView::_clearCenter()
{
    _tft->fillRect(WatchSettings::get<int>(borderSize), WatchSettings::get<int>(borderSize), (_tft->width() - (2 * WatchSettings::get<int>(borderSize))), (_tft->height() - (2 * WatchSettings::get<int>(borderSize))), WatchSettings::get<uint16_t>(topicTimer_BLACK));
}

void HomeView::_setClickableItems()
{
    _items[0].type = ClickableItemType::GO_TO_SETTINGS;
    _items[0].x = (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder));
    _items[0].y = _tft->height() - (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder) + WatchSettings::get<int>(iconSize));
    _items[0].width = WatchSettings::get<int>(iconSize);
    _items[0].height = WatchSettings::get<int>(iconSize);
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
    if (_tft == nullptr ||
        _border == nullptr ||
        _vRTCProvider == nullptr ||
        _dateTime == nullptr ||
        _hasBluetoothConnnection == nullptr)
    {
        return;
    }

    if (clearScreen)
    {
        _clearCenter();
    }

    _tft->loadFont(AA_FONT_BIGGEST);
    _tft->setTextDatum(MC_DATUM);
    _tft->drawString(StringHelper::padZeroLeft(String(_dateTime->hours)) + ':' + StringHelper::padZeroLeft(String(_dateTime->minutes)), _tft->width() / 2, _tft->height() / 2);

    _tft->loadFont(AA_FONT_SMALL);
    _tft->setTextDatum(BC_DATUM);
    _tft->drawString(StringHelper::padZeroLeft(String(_dateTime->day)) + '-' + StringHelper::padZeroLeft(String(_dateTime->month)) + '-' + StringHelper::padZeroLeft(String(_dateTime->year)),
                     _tft->width() / 2,
                     _tft->height() - (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder)));

    _border->set(100, WatchSettings::get<uint16_t>(topicTimer_BLACK));

    _tft->setSwapBytes(true);
    _tft->pushImage((WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder)),
                    _tft->height() - (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder) + (WatchSettings::get<int>(iconSize) * 2) + WatchSettings::get<int>(iconMargin)),
                    WatchSettings::get<int>(iconSize), WatchSettings::get<int>(iconSize),
                    *_hasBluetoothConnnection ? Bluetooth : NoBluetooth,
                    TFT_PINK);
    _tft->pushImage((WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder)),
                    _tft->height() - (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder) + WatchSettings::get<int>(iconSize)),
                    WatchSettings::get<int>(iconSize), WatchSettings::get<int>(iconSize),
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