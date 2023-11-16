#include "View.h"

void View::_clearCenter()
{
    _tft->fillRect(_border->getHeight(), _border->getHeight(), (_tft->width() - (2 * _border->getHeight())), (_tft->height() - (2 * _border->getHeight())), WatchSettings::topicTimer_GRAY);
}

void View::_drawHomeView(int clearScreen)
{
    if (clearScreen)
    {
        _clearCenter();
    }

    _tft->setTextSize(6);
    _tft->setTextDatum(MC_DATUM);
    String s = StringHelper::padZeroLeft(String(_dateTime->hours)) + ':' + StringHelper::padZeroLeft(String(_dateTime->minutes));
    _tft->drawString(s, _tft->width() / 2, _tft->height() / 2);

    _border->set(100, WatchSettings::topicTimer_GRAY);
}

void View::_drawIdle(int clearScreen)
{
    if (clearScreen)
    {
        _clearCenter();
    }

    _tft->setTextSize(2);
    _tft->setTextDatum(TC_DATUM);
    _tft->drawString(String(*_currentViewIndex) + "/" + String(*_amountOfActiveViews - 1), _tft->width() / 2, 13);
    _tft->drawString(_topic.name, _tft->width() / 2, 30);

    _tft->setTextSize(6);
    _tft->setTextDatum(MC_DATUM);
    String s = StringHelper::padZeroLeft(String(_dateTime->hours)) + ':' + StringHelper::padZeroLeft(String(_dateTime->minutes));
    _tft->drawString(s, _tft->width() / 2, _tft->height() / 2);

    _border->set(100, _topic.color);
}

void View::_drawTracking(int clearScreen)
{
    if (clearScreen)
    {
        _clearCenter();
    }
}

void View::init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider, int *amountOfActiveViews, int *currentViewIndex)
{
    _tft = tft;
    _border = border;
    _vRTCProvider = vRTCProvider;
    _dateTime = _vRTCProvider->getTime();
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

    switch (viewState)
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