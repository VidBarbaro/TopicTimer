#include "ViewController.h"

View *ViewController::_views[102];
Border *ViewController::_border = nullptr;
TFT_eSPI *ViewController::_tft = nullptr;
VirtualRTCProvider *ViewController::_vRTCProvider = nullptr;
int ViewController::_hasBluetoothConnnection = false;
int ViewController::_activeViewCount = 0;
int ViewController::_viewIndex = 1;

ViewController::~ViewController()
{
    for (int i = 0; i < WatchSettings::get<int>(maxAmountOfViews); i++)
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
    if (_views[_viewIndex]->getViewState())
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
            case ClickableItemType::SETTING:
            {
                SettingsView *sView = (SettingsView *)_views[_viewIndex];
                sView->editSetting(i);
                break;
            }
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
    if (_views[_viewIndex]->getViewState())
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
    if (_views[_viewIndex]->getViewState())
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
    if (_views[_viewIndex]->getViewState())
    {
        if (_views[_viewIndex]->getViewType() == ViewTypes::SETTINGS)
        {
            SettingsView *sView = (SettingsView *)_views[_viewIndex];
            sView->decreaseValue();
        }
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
    if (_views[_viewIndex]->getViewState())
    {
        if (_views[_viewIndex]->getViewType() == ViewTypes::SETTINGS)
        {
            SettingsView *sView = (SettingsView *)_views[_viewIndex];
            sView->incrementValue();
        }
        return;
    }

    _viewIndex++;
    if (_viewIndex >= WatchSettings::get<int>(maxAmountOfViews) || _views[_viewIndex] == nullptr)
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

void ViewController::addTopic(Topic topic)
{
    if (_activeViewCount < WatchSettings::get<int>(amountOfNonTopicViews) || _tft == nullptr || _border == nullptr || _vRTCProvider == nullptr)
    {
        return;
    }

    TopicView *tView = new TopicView;
    tView->init(_tft, _border, _vRTCProvider, &_hasBluetoothConnnection, &_activeViewCount, &_viewIndex);
    tView->setTopic(topic);
    _views[_activeViewCount] = tView;

    _activeViewCount++;
}

void ViewController::editTopic(int index, Topic topic)
{
    if (_activeViewCount < WatchSettings::get<int>(amountOfNonTopicViews) ||
        index < WatchSettings::get<int>(amountOfNonTopicViews) ||
        index > WatchSettings::get<int>(maxAmountOfViews) - 1 ||
        _views[index] == nullptr)
    {
        return;
    }

    TopicView *tView = (TopicView *)_views[index];
    tView->setTopic(topic);
}

void ViewController::removeTopic(int index)
{
    if (_activeViewCount < WatchSettings::get<int>(amountOfNonTopicViews) ||
        index < WatchSettings::get<int>(amountOfNonTopicViews) ||
        index > WatchSettings::get<int>(maxAmountOfViews) - 1)
    {
        Serial.println("Fail save triggered!");
        return;
    }

    if (index == _viewIndex)
    {
        Serial.println("Index to remove is current view");

        _viewIndex = 1;
        _views[_viewIndex]->draw(true);
    }
    // TODO FIX CRASH WHEN REMOVING LAST TOPIC
    Serial.println("Deleting... the view at index!");
    delete _views[index];
    _views[index] = nullptr;
    Serial.println("Deleted the view at index!");

    for (int i = index; i < WatchSettings::get<int>(maxAmountOfViews) - 2; ++i)
    {
        Serial.println("Shifting array");
        _views[i] = _views[i + 1];
    }

    _views[WatchSettings::get<int>(maxAmountOfViews) - 1] = nullptr;
    _activeViewCount--;
    Serial.println("Done!");
}

void ViewController::removeAllTopics()
{
    if (_activeViewCount < WatchSettings::get<int>(amountOfNonTopicViews))
    {
        return;
    }

    _viewIndex = 1;

    for (int i = WatchSettings::get<int>(amountOfNonTopicViews); i < WatchSettings::get<int>(maxAmountOfViews); i++)
    {
        if (_views[i] == nullptr)
        {
            break;
        }

        delete _views[i];
        _views[i] = nullptr;
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
    }
}

void ViewController::togglePauseTracking()
{
    _vRTCProvider->togglePauseTopicTimer();
}

void ViewController::stopTracking()
{
    if (_views[_viewIndex]->getViewType() == ViewTypes::TOPIC && _views[_viewIndex]->getViewState())
    {
        TopicView *tView = (TopicView *)_views[_viewIndex];
        tView->stopTracking();
    }
}

void ViewController::stopEditing()
{
    if (_views[_viewIndex]->getViewType() != ViewTypes::SETTINGS)
    {
        return;
    }

    SettingsView *sView = (SettingsView *)_views[_viewIndex];
    sView->stopEditing();
}

int ViewController::getCurrentViewState()
{
    return _views[_viewIndex]->getViewState();
}

int ViewController::getCurrentViewType()
{
    return _views[_viewIndex]->getViewType();
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
