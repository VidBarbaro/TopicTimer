#include "SettingsView.h"

void SettingsView::_clearCenter()
{
    _tft->fillRect(WatchSettings::get<int>(borderSize), WatchSettings::get<int>(borderSize), (_tft->width() - (2 * WatchSettings::get<int>(borderSize))), (_tft->height() - (2 * WatchSettings::get<int>(borderSize))), WatchSettings::get<uint16_t>(topicTimer_BLACK));
}

void SettingsView::_setClickableItems()
{
    for (int i = 0; i < _amountOfSettingsPerPage; i++)
    {
        _items[i].x = 0;
        _items[i].y = 0;
        _items[i].width = 0;
        _items[i].height = 0;
    }

    if (_editableSettings[0 + (_amountOfSettingsPerPage * _verticalPageIndex)].displayName != "")
    {
        _items[0].type = ClickableItemType::SETTING;
        _items[0].x = (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder));
        _items[0].y = (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder));
        _items[0].width = (WatchSettings::get<int>(screenHorizontal) - (WatchSettings::get<int>(borderSize) * 2) - (WatchSettings::get<int>(marginFromBorder) * 2));
        _items[0].height = _settingsHeight;
    }

    if (_editableSettings[1 + (_amountOfSettingsPerPage * _verticalPageIndex)].displayName != "")
    {
        _items[1].type = ClickableItemType::SETTING;
        _items[1].x = (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder));
        _items[1].y = (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder) + _settingsHeight);
        _items[1].width = (WatchSettings::get<int>(screenHorizontal) - (WatchSettings::get<int>(borderSize) * 2) - (WatchSettings::get<int>(marginFromBorder) * 2));
        _items[1].height = _settingsHeight;
    }

    if (_editableSettings[2 + (_amountOfSettingsPerPage * _verticalPageIndex)].displayName != "")
    {
        _items[2].type = ClickableItemType::SETTING;
        _items[2].x = (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder));
        _items[2].y = (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder) + (_settingsHeight * 2));
        _items[2].width = (WatchSettings::get<int>(screenHorizontal) - (WatchSettings::get<int>(borderSize) * 2) - (WatchSettings::get<int>(marginFromBorder) * 2));
        _items[2].height = _settingsHeight;
    }
}

void SettingsView::_drawSelectionView()
{
    _border->set(100, WatchSettings::get<uint16_t>(topicTimer_BLACK));

    for (int i = 0; i < _amountOfSettingsPerPage; i++)
    {
        WatchSetting ws = _editableSettings[i + (_amountOfSettingsPerPage * _verticalPageIndex)];

        if (ws.displayName != "")
        {
            _tft->loadFont(AA_FONT_SMALL);
            _tft->setTextDatum(ML_DATUM);
            _tft->drawString(ws.displayName, WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder), WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder) + (_settingsHeight * i) + (_settingsHeight / 3));
            _tft->setTextDatum(MR_DATUM);

            switch (ws.type)
            {
            case WatchSettingType::INT:
                _tft->drawString(String(WatchSettings::get<int>(ws.name)), WatchSettings::get<int>(screenHorizontal) - WatchSettings::get<int>(borderSize) - WatchSettings::get<int>(marginFromBorder), WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder) + (_settingsHeight * i) + (_settingsHeight / 3));
                break;
            case WatchSettingType::UINT16_T:
                _tft->drawString(String(WatchSettings::get<uint16_t>(ws.name)), WatchSettings::get<int>(screenHorizontal) - WatchSettings::get<int>(borderSize) - WatchSettings::get<int>(marginFromBorder), WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder) + (_settingsHeight * i) + (_settingsHeight / 3));
                break;
            default:
                break;
            }
        }

        if (i != _amountOfSettingsPerPage - 1)
        {
            _tft->fillRect(WatchSettings::get<int>(borderSize), _settingsHeight * (i + 1), WatchSettings::get<int>(screenHorizontal) - (WatchSettings::get<int>(borderSize) * 2), 1, WatchSettings::get<uint16_t>(topicTimer_GRAY));
        }
    }
}

void SettingsView::_drawEditingView()
{
    WatchSetting setting = _editableSettings[_editSettingsIndex + (_amountOfSettingsPerPage * _verticalPageIndex)];
    _tft->loadFont(AA_FONT_SMALL);
    _tft->setTextDatum(TC_DATUM);
    _tft->drawString(setting.displayName, _tft->width() / 2, (WatchSettings::get<int>(borderSize) + WatchSettings::get<int>(marginFromBorder)));

    _border->set(100, TFT_RED);
    _tft->loadFont(AA_FONT_BIGGEST);
    _tft->setTextDatum(MC_DATUM);
    switch (setting.type)
    {
    case WatchSettingType::INT:
        _tft->drawString(String(setting.value.intValue), _tft->width() / 2, _tft->height() / 2);
        break;
    case WatchSettingType::UINT16_T:
        _tft->drawString(String(setting.value.uint16_tValue), _tft->width() / 2, _tft->height() / 2);
        break;
    default:
        break;
    }
}

void SettingsView::_playUpdatedPattern(WatchSetting setting)
{
    int selectedVibrationPattern = WatchSettings::get<int>(vibrationPattern);
    int selectedSoundPattern = WatchSettings::get<int>(soundPattern);
    FeedbackPattern *pattern = nullptr;
    FeedbackProvider::cancel();

    switch (setting.name)
    {
    case vibrationLevel:
    case vibrationPattern:
        pattern = PatternFactory::createVibrationPattern(selectedVibrationPattern);
        if (pattern != nullptr)
        {
            FeedbackProvider::playPattern(pattern);
        }
        break;
    case soundLevel:
    case soundPattern:
        pattern = PatternFactory::createSoundPattern(selectedSoundPattern);
        if (pattern != nullptr)
        {
            FeedbackProvider::playPattern(pattern);
        }
        break;
    default:
        break;
    }
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
    if (_tft == nullptr ||
        _border == nullptr ||
        _vRTCProvider == nullptr ||
        _hasBluetoothConnnection == nullptr)
    {
        return;
    }

    if (clearScreen)
    {
        _clearCenter();
    }

    switch (_viewState)
    {
    case SettingViewState::EDITING:
        _drawEditingView();
        break;
    default:
        _drawSelectionView();
        break;
    }
}

ViewTypes SettingsView::getViewType() const
{
    return ViewTypes::SETTINGS;
}

int SettingsView::getViewState() const
{
    return _viewState == SettingViewState::IDLE ? 0 : 1;
}

ClickableItem *SettingsView::getListOfClickableItems(int *arraySize)
{
    *arraySize = sizeof(_items) / sizeof(_items[0]);
    return &_items[0];
}

void SettingsView::pageDown()
{
    _verticalPageIndex++;

    if (_editableSettings[0 + (_amountOfSettingsPerPage * _verticalPageIndex)].displayName == "")
    {
        _verticalPageIndex--;
        return;
    }

    _setClickableItems();
    draw(true);
}

void SettingsView::pageUp()
{
    _verticalPageIndex--;

    if (_verticalPageIndex < 0)
    {
        _verticalPageIndex = 0;
        return;
    }

    _setClickableItems();
    draw(true);
}

void SettingsView::editSetting(int index)
{
    if (_viewState == SettingViewState::EDITING)
    {
        return;
    }

    _editSettingsIndex = index;
    _viewState = SettingViewState::EDITING;
    draw(true);
}

void SettingsView::stopEditing()
{
    _viewState = SettingViewState::IDLE;
    _editSettingsIndex = -1;
    FeedbackProvider::cancel();
    draw(true);
}

void SettingsView::incrementValue()
{
    if (_viewState != SettingViewState::EDITING)
    {
        return;
    }

    WatchSetting setting = _editableSettings[_editSettingsIndex + (_amountOfSettingsPerPage * _verticalPageIndex)];
    switch (setting.type)
    {
    case WatchSettingType::INT:
        if (setting.value.intValue + 1 > setting.maxValue.intValue)
        {
            return;
        }
        WatchSettings::set<int>(setting.name, ++setting.value.intValue);
        break;
    case WatchSettingType::UINT16_T:
        if (setting.value.intValue + 1 > setting.maxValue.intValue)
        {
            return;
        }
        WatchSettings::set<uint16_t>(setting.name, ++setting.value.uint16_tValue);
        break;
    default:
        break;
    }

    switch (setting.name)
    {
    case vibrationPattern:
        FeedbackProvider::setVibrationPattern(PatternFactory::createVibrationPattern(WatchSettings::get<int>(vibrationPattern)));
        _playUpdatedPattern(setting);
        break;
    case vibrationLevel:
        _playUpdatedPattern(setting);
        break;
    case soundPattern:
        FeedbackProvider::setSoundPattern(PatternFactory::createSoundPattern(WatchSettings::get<int>(soundPattern)));
        _playUpdatedPattern(setting);
        break;
    case soundLevel:
        _playUpdatedPattern(setting);
        break;
    default:
        break;
    }

    _editableSettings = WatchSettings::getEditableSettings(&_amountOfEditableSettings);
    draw(true);
}

void SettingsView::decreaseValue()
{
    if (_viewState != SettingViewState::EDITING)
    {
        return;
    }

    WatchSetting setting = _editableSettings[_editSettingsIndex + (_amountOfSettingsPerPage * _verticalPageIndex)];
    switch (setting.type)
    {
    case WatchSettingType::INT:
        if (setting.value.intValue - 1 < setting.minValue.intValue)
        {
            return;
        }
        WatchSettings::set<int>(setting.name, --setting.value.intValue);
        break;
    case WatchSettingType::UINT16_T:
        if (setting.value.uint16_tValue - 1 < setting.minValue.intValue)
        {
            return;
        }
        WatchSettings::set<uint16_t>(setting.name, --setting.value.uint16_tValue);
        break;
    default:
        break;
    }

    if (setting.name == vibrationPattern || setting.name == soundPattern ||
        setting.name == vibrationLevel || setting.name == soundLevel)
    {
        _playUpdatedPattern(setting);
    }

    _editableSettings = WatchSettings::getEditableSettings(&_amountOfEditableSettings);
    draw(true);
}
