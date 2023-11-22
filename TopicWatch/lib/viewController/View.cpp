#include "View.h"

void View::_clearCenter()
{
    _tft->fillRect(WatchSettings::borderSize, WatchSettings::borderSize, (_tft->width() - (2 * WatchSettings::borderSize)), (_tft->height() - (2 * WatchSettings::borderSize)), WatchSettings::topicTimer_BLACK);
}

void View::_drawHomeView(int clearScreen)
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
                    NoBluetooth,
                    TFT_PINK);
    _tft->pushImage((WatchSettings::borderSize + WatchSettings::marginFromBorder),
                    _tft->height() - (WatchSettings::borderSize + WatchSettings::marginFromBorder + WatchSettings::iconSize),
                    WatchSettings::iconSize, WatchSettings::iconSize,
                    Settings,
                    TFT_PINK);
    _tft->setSwapBytes(false);
}

void View::_drawIdle(int clearScreen)
{
    if (clearScreen)
    {
        _clearCenter();
    }

    _tft->setTextSize(2);
    _tft->setTextDatum(TC_DATUM);
    _tft->drawString(String(*_currentViewIndex) + "/" + String(*_amountOfActiveViews - 1), _tft->width() / 2, (WatchSettings::borderSize + WatchSettings::marginFromBorder));
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
                    NoBluetooth,
                    TFT_PINK);
    _tft->pushImage((WatchSettings::borderSize + WatchSettings::marginFromBorder),
                    _tft->height() - (WatchSettings::borderSize + WatchSettings::marginFromBorder + WatchSettings::iconSize),
                    WatchSettings::iconSize, WatchSettings::iconSize,
                    Settings,
                    TFT_PINK);
    _tft->setSwapBytes(false);
}

void View::_drawTracking(int clearScreen)
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

void View::init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider, int *amountOfActiveViews, int *currentViewIndex)
{
    _tft = tft;
    _border = border;
    _vRTCProvider = vRTCProvider;
    _dateTime = _vRTCProvider->getTime();
    _trackingDateTime = _vRTCProvider->getTrackingTime();
    _amountOfActiveViews = amountOfActiveViews;
    _currentViewIndex = currentViewIndex;
    _initialized = true;
}

void View::init(Topic topic, TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider, int *amountOfActiveViews, int *currentViewIndex)
{
    _topic = topic;
    _tft = tft;
    _border = border;
    _vRTCProvider = vRTCProvider;
    _dateTime = _vRTCProvider->getTime();
    _trackingDateTime = _vRTCProvider->getTrackingTime();
    _amountOfActiveViews = amountOfActiveViews;
    _currentViewIndex = currentViewIndex;
    _initialized = true;
}

int View::isInitialized()
{
    return _initialized;
}

void View::draw(int clearScreen)
{
    if (_topic.id < 0)
    {
        _drawHomeView(clearScreen);
        return;
    }

    switch (_viewState)
    {
    case ViewState::IDLE:
        _drawIdle(clearScreen);
        break;
    case ViewState::TRACKING:
        _drawTracking(clearScreen);
        break;
    default:
        break;
    }
}

void View::startTracking()
{
    _viewState = ViewState::TRACKING;
    _vRTCProvider->startTopicTimer();
    draw(true);
}

void View::stopTracking()
{
    _viewState = ViewState::IDLE;
    _vRTCProvider->stopTopicTimer();
    draw(true);
}
