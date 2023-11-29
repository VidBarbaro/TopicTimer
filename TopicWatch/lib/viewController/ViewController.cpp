#include "ViewController.h"

ViewController::~ViewController()
{
    for (int i = 0; i < WatchSettings::maxAmountOfViews; i++)
    {
        delete _views[i];
        _views[i] = nullptr;
    }
}

void ViewController::init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider)
{
    _tft = tft;
    _border = border;
    _vRTCProvider = vRTCProvider;

    SettingsView *sView = new SettingsView;
    sView->init(_tft, _border, _vRTCProvider, &_hasBluetoothConnnection);
    _views[_activeViewCount] = sView;
    _activeViewCount++;

    HomeView *hView = new HomeView;
    hView->init(_tft, _border, _vRTCProvider, &_hasBluetoothConnnection);
    _views[_activeViewCount] = hView;
    _activeViewCount++;

    drawCurrentView(true);
}

void ViewController::click(int x, int y)
{
    if (_currentViewIsTracking)
    {
        return;
    }

    int itemArraySize = 0;
    ClickableItem *itemArray = _views[_viewIndex]->getListOfClickableItems(&itemArraySize);

    for (int i = 0; i < itemArraySize; i++)
    {
        if (x >= itemArray->x && x <= itemArray->x + itemArray->width &&
            y >= itemArray->y && y <= itemArray->y + itemArray->height)
        {
            switch (itemArray->type)
            {
            case ClickableItemType::GO_TO_SETTINGS:
                settings();
                break;
            default:
                break;
            }
            break;
        }

        itemArray++;
    }
}

void ViewController::home()
{
    if (_currentViewIsTracking)
    {
        return;
    }

    if (_viewIndex == 1)
    {
        return;
    }

    _viewIndex = 1;
    drawCurrentView(true);
}

void ViewController::settings()
{
    if (_currentViewIsTracking)
    {
        return;
    }

    if (_viewIndex == 0)
    {
        return;
    }

    _viewIndex = 0;
    drawCurrentView(true);
}

void ViewController::nextLeft()
{
    if (_currentViewIsTracking)
    {
        return;
    }

    _viewIndex--;
    if (_viewIndex < 0 || _views[_viewIndex] == nullptr)
    {
        _viewIndex++;
        return;
    }

    drawCurrentView(true);
}

void ViewController::nextRight()
{
    if (_currentViewIsTracking)
    {
        return;
    }

    _viewIndex++;
    if (_viewIndex >= WatchSettings::maxAmountOfViews || _views[_viewIndex] == nullptr)
    {
        _viewIndex--;
        return;
    }

    drawCurrentView(true);
}

void ViewController::nextUp()
{
    if (_views[_viewIndex]->getViewType() == ViewTypes::SETTINGS)
    {
        SettingsView *sView = (SettingsView *)_views[_viewIndex];
    }
}

void ViewController::nextDown()
{
    if (_views[_viewIndex]->getViewType() == ViewTypes::SETTINGS)
    {
        SettingsView *sView = (SettingsView *)_views[_viewIndex];
    }
}

void ViewController::addView(Topic topic)
{
    TopicView *tView = new TopicView;
    tView->init(_tft, _border, _vRTCProvider, &_hasBluetoothConnnection, &_activeViewCount, &_viewIndex);
    tView->setTopic(topic);
    _views[_activeViewCount] = tView;

    _activeViewCount++;
}

void ViewController::removeView(int viewIndex)
{
    if (viewIndex > 1)
    {
        _activeViewCount--;
    }
}

void ViewController::drawCurrentView(int clearScreen)
{
    _views[_viewIndex]->draw(clearScreen);
}

void ViewController::startTracking()
{
    if (_views[_viewIndex]->getViewType() == ViewTypes::TOPIC)
    {
        TopicView *tView = (TopicView *)_views[_viewIndex];
        tView->startTracking();

        _currentViewIsTracking = true;
    }
}

void ViewController::togglePauseTracking()
{
    _vRTCProvider->togglePauseTopicTimer();
}

void ViewController::stopTracking()
{
    if (_currentViewIsTracking && _views[_viewIndex]->getViewType() == ViewTypes::TOPIC)
    {
        TopicView *tView = (TopicView *)_views[_viewIndex];
        tView->stopTracking();

        _currentViewIsTracking = false;
    }
}

int ViewController::getCurrentViewTrackingState()
{
    return _currentViewIsTracking;
}

void ViewController::setHasBluetoothConnection()
{
    _hasBluetoothConnnection = true;
    drawCurrentView(true);
}

void ViewController::setHasNoBluetoothConnection()
{
    _hasBluetoothConnnection = false;
    drawCurrentView(true);
}
