#include "ViewController.h"

void ViewController::init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider)
{
    _tft = tft;
    _border = border;
    _vRTCProvider = vRTCProvider;

    addView();
    _allViews[_currentViewIndex].draw();
}

void ViewController::home()
{
    if (_currentViewIsTracking)
    {
        return;
    }

    if (_currentViewIndex == 0)
    {
        return;
    }

    _currentViewIndex = 0;
    _allViews[_currentViewIndex].draw(true);
}

void ViewController::nextLeft()
{
    if (_currentViewIsTracking)
    {
        return;
    }

    _currentViewIndex--;
    if (_currentViewIndex < 0)
    {
        _currentViewIndex = 0;
        return;
    }

    if (!_allViews[_currentViewIndex].isInitialized())
    {
        _currentViewIndex++;
        return;
    }

    _allViews[_currentViewIndex].draw(true);
}

void ViewController::nextRight()
{
    if (_currentViewIsTracking)
    {
        return;
    }

    _currentViewIndex++;
    if (_currentViewIndex >= WatchSettings::maxAmountOfViews)
    {
        _currentViewIndex = WatchSettings::maxAmountOfViews - 1;
    }

    if (!_allViews[_currentViewIndex].isInitialized())
    {
        _currentViewIndex--;
        return;
    }

    _allViews[_currentViewIndex].draw(true);
}

void ViewController::addView()
{
    _allViews[_activeViewCount].init(_tft, _border, _vRTCProvider, &_activeViewCount, &_currentViewIndex, &_hasBluetoothConnnection);

    _activeViewCount++;
}

void ViewController::addView(Topic topic)
{
    _allViews[_activeViewCount].init(topic, _tft, _border, _vRTCProvider, &_activeViewCount, &_currentViewIndex, &_hasBluetoothConnnection);

    _activeViewCount++;
}

void ViewController::removeView(int viewIndex)
{
    if (viewIndex > 0)
    {
        _activeViewCount--;
    }
}

void ViewController::drawCurrentView()
{
    _allViews[_currentViewIndex].draw();
}

void ViewController::startTracking()
{
    if (_currentViewIndex > 0)
    {
        _currentViewIsTracking = true;
        _allViews[_currentViewIndex].startTracking();
    }
}

void ViewController::togglePauseTracking()
{
    _vRTCProvider->togglePauseTopicTimer();
}

void ViewController::stopTracking()
{
    if (_currentViewIndex > 0)
    {
        _currentViewIsTracking = false;
        _allViews[_currentViewIndex].stopTracking();
    }
}

int ViewController::getCurrentViewState()
{
    return _currentViewIsTracking;
}

void ViewController::toggleHasBluetoothConnection()
{
    _hasBluetoothConnnection = !_hasBluetoothConnnection;
    _allViews[_currentViewIndex].draw(true);
}