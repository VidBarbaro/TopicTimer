#include "TopicView.h"

void TopicView::_clearCenter()
{
    _tft->fillRect(WatchSettings::borderSize, WatchSettings::borderSize, (_tft->width() - (2 * WatchSettings::borderSize)), (_tft->height() - (2 * WatchSettings::borderSize)), WatchSettings::topicTimer_BLACK);
}

void TopicView::_drawIdle(int clearScreen)
{
    if (clearScreen)
    {
        _clearCenter();
    }

    _tft->setTextSize(2);
    _tft->setTextDatum(TC_DATUM);
    _tft->drawString(String(*_currentViewIndex - 1) + "/" + String(*_amountOfActiveViews - WatchSettings::amountOfNonTopicViews), _tft->width() / 2, (WatchSettings::borderSize + WatchSettings::marginFromBorder));
    _tft->drawString(_topic.name, _tft->width() / 2, (WatchSettings::borderSize + WatchSettings::marginFromBorder + WatchSettings::textMargin));

    _tft->setTextSize(6);
    _tft->setTextDatum(MC_DATUM);
    _tft->drawString(StringHelper::padZeroLeft(String(_dateTime->hours)) + ':' + StringHelper::padZeroLeft(String(_dateTime->minutes)), _tft->width() / 2, _tft->height() / 2);

    _tft->setTextSize(2);
    _tft->setTextDatum(BC_DATUM);
    _tft->drawString(StringHelper::padZeroLeft(String(_dateTime->day)) + '-' + StringHelper::padZeroLeft(String(_dateTime->month)) + '-' + StringHelper::padZeroLeft(String(_dateTime->year)),
                     _tft->width() / 2,
                     _tft->height() - (WatchSettings::borderSize + WatchSettings::marginFromBorder));

    _border->set(100, _topic.color);

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

void TopicView::_drawTracking(int clearScreen)
{
    if (clearScreen)
    {
        _clearCenter();
    }

    _tft->setTextSize(2);
    _tft->setTextDatum(TC_DATUM);
    _tft->drawString(_topic.name, _tft->width() / 2, (WatchSettings::borderSize + WatchSettings::marginFromBorder));

    _tft->setTextSize(6);
    _tft->setTextDatum(MC_DATUM);
    _tft->drawString(StringHelper::padZeroLeft(String(_trackingDateTime->hours)) + ':' + StringHelper::padZeroLeft(String(_trackingDateTime->minutes)) + ':' + StringHelper::padZeroLeft(String(_trackingDateTime->seconds)),
                     _tft->width() / 2,
                     _tft->height() / 2);

    _tft->setTextSize(2);
    _tft->setTextDatum(BC_DATUM);
    _tft->drawString(StringHelper::padZeroLeft(String(_dateTime->hours)) + ':' + StringHelper::padZeroLeft(String(_dateTime->minutes)),
                     _tft->width() / 2,
                     _tft->height() - (WatchSettings::borderSize + WatchSettings::marginFromBorder + WatchSettings::textMargin));
    _tft->drawString(StringHelper::padZeroLeft(String(_dateTime->day)) + '-' + StringHelper::padZeroLeft(String(_dateTime->month)) + '-' + StringHelper::padZeroLeft(String(_dateTime->year)),
                     _tft->width() / 2,
                     _tft->height() - (WatchSettings::borderSize + WatchSettings::marginFromBorder));

    _border->set(100, _topic.color);
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
}

void TopicView::draw(int clearScreen)
{
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

void TopicView::setTopic(Topic topic)
{
    _topic = topic;
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
