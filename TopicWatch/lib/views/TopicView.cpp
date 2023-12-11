#include "TopicView.h"

TopicView::~TopicView()
{
    _tft->unloadFont();
    _tft = nullptr;
    _border = nullptr;
    _dateTime = nullptr;
    _trackingDateTime = nullptr;
    _vRTCProvider = nullptr;
    _amountOfActiveViews = nullptr;
    _currentViewIndex = nullptr;
    _hasBluetoothConnnection = nullptr;
}

void TopicView::_clearCenter()
{
    _tft->fillRect(WatchSettings::get<int>(borderSize), WatchSettings::get<int>(borderSize), (_tft->width() - (2 * WatchSettings::get<int>(borderSize))), (_tft->height() - (2 * WatchSettings::get<int>(borderSize))), WatchSettings::get<uint16_t>(topicTimer_BLACK));
}

void TopicView::_drawIdle(int clearScreen)
{
    if (clearScreen)
    {
        _clearCenter();
    }

    _tft->loadFont(AA_FONT_SMALL);
    _tft->setTextDatum(TC_DATUM);
    _tft->drawString(String(*_currentViewIndex - 1) + "/" + String(*_amountOfActiveViews - WatchSettings::get<int>(amountOfNonTopicViews)), _tft->width() / 2, (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder)));
    _tft->drawString(_topic.name, _tft->width() / 2, (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder) + WatchSettings::get<int>(textMargin)));

    _tft->loadFont(AA_FONT_BIGGEST);
    _tft->setTextDatum(MC_DATUM);
    _tft->drawString(StringHelper::padZeroLeft(String(_dateTime->hours)) + ':' + StringHelper::padZeroLeft(String(_dateTime->minutes)), _tft->width() / 2, _tft->height() / 2);

    _tft->loadFont(AA_FONT_SMALL);
    _tft->setTextDatum(BC_DATUM);
    _tft->drawString(StringHelper::padZeroLeft(String(_dateTime->day)) + '-' + StringHelper::padZeroLeft(String(_dateTime->month)) + '-' + StringHelper::padZeroLeft(String(_dateTime->year)),
                     _tft->width() / 2,
                     _tft->height() - (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder)));

    _border->set(100, _topic.color);

    _tft->setSwapBytes(true);
    _tft->pushImage(_tft->width() - (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder) + WatchSettings::get<int>(iconSizeSmall) - 4), // the image is 4 pixels off, so we manually add those
                    (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder)),
                    WatchSettings::get<int>(iconSizeSmall), WatchSettings::get<int>(iconSizeSmall),
                    *_hasBluetoothConnnection ? BluetoothSmall : NoBluetoothSmall,
                    TFT_PINK);
    _tft->pushImage((WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder)),
                    _tft->height() - (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder) + WatchSettings::get<int>(iconSize)),
                    WatchSettings::get<int>(iconSize), WatchSettings::get<int>(iconSize),
                    Settings,
                    TFT_PINK);
    _tft->setSwapBytes(false);
}

void TopicView::_drawTracking(int clearScreen)
{
    // TODO See if I can fix the shift when seconds ends with 1
    if (clearScreen)
    {
        _clearCenter();
    }

    _tft->loadFont(AA_FONT_SMALL);
    _tft->setTextDatum(TC_DATUM);
    _tft->drawString(_topic.name, _tft->width() / 2, (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder)));

    _tft->loadFont(AA_FONT_BIGGEST);
    _tft->setTextDatum(MC_DATUM);
    _tft->drawString(StringHelper::padZeroLeft(String(_trackingDateTime->hours)) + ':' + StringHelper::padZeroLeft(String(_trackingDateTime->minutes)) + ':' + StringHelper::padZeroLeft(String(_trackingDateTime->seconds)),
                     _tft->width() / 2,
                     _tft->height() / 2);

    _tft->loadFont(AA_FONT_SMALL);
    _tft->setTextDatum(BC_DATUM);
    _tft->drawString(StringHelper::padZeroLeft(String(_dateTime->hours)) + ':' + StringHelper::padZeroLeft(String(_dateTime->minutes)),
                     _tft->width() / 2,
                     _tft->height() - (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder) + WatchSettings::get<int>(textMargin)));
    _tft->drawString(StringHelper::padZeroLeft(String(_dateTime->day)) + '-' + StringHelper::padZeroLeft(String(_dateTime->month)) + '-' + StringHelper::padZeroLeft(String(_dateTime->year)),
                     _tft->width() / 2,
                     _tft->height() - (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder)));

    _border->set(100, _topic.color);
}

void TopicView::_setClickableItems()
{
    _items[0].type = ClickableItemType::GO_TO_SETTINGS;
    _items[0].x = (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder));
    _items[0].y = _tft->height() - (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder) + WatchSettings::get<int>(iconSize));
    _items[0].width = WatchSettings::get<int>(iconSize);
    _items[0].height = WatchSettings::get<int>(iconSize);
}

void TopicView::init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider, int *hasBluetoothConnnection, int *amountOfActiveViews, int *currentViewIndex)
{
    _tft = tft;
    _border = border;
    _vRTCProvider = vRTCProvider;
    _dateTime = _vRTCProvider->getTime();
    _trackingDateTime = _vRTCProvider->getTrackingTime();
    _amountOfActiveViews = amountOfActiveViews;
    _currentViewIndex = currentViewIndex;
    _hasBluetoothConnnection = hasBluetoothConnnection;

    _setClickableItems();
}

void TopicView::draw(int clearScreen)
{
    if (_tft == nullptr ||
        _border == nullptr ||
        _vRTCProvider == nullptr ||
        _dateTime == nullptr ||
        _trackingDateTime == nullptr ||
        _amountOfActiveViews == nullptr ||
        _currentViewIndex == nullptr ||
        _hasBluetoothConnnection == nullptr)
    {
        return;
    }

    switch (_viewState)
    {
    case TopicViewState::IDLE:
        _drawIdle(clearScreen);
        break;
    case TopicViewState::TRACKING:
        _drawTracking(clearScreen);
        break;
    default:
        // something went wrong somewhere
        break;
    }
}

ViewTypes TopicView::getViewType() const
{
    return ViewTypes::TOPIC;
}

int TopicView::getViewState() const
{
    return _viewState == TopicViewState::IDLE ? 0 : 1;
}

ClickableItem *TopicView::getListOfClickableItems(int *arraySize)
{
    *arraySize = sizeof(_items) / sizeof(_items[0]);
    return &_items[0];
}

void TopicView::setTopic(Topic topic)
{
    _topic = topic;
}

Topic TopicView::getTopic()
{
    return _topic;
}

void TopicView::startTracking()
{
    _viewState = TopicViewState::TRACKING;
    _vRTCProvider->startTopicTimer();
    draw(true);
}

void TopicView::stopTracking()
{
    _viewState = TopicViewState::IDLE;
    _vRTCProvider->stopTopicTimer();
    draw(true);
}
