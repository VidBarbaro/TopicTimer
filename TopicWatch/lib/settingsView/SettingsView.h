#ifndef SETTINGS_VIEW
#define SETTIGNS_VIEW

#include "View.h"

enum class SettingViewState
{
    IDLE,
    EDITING,
};

class SettingsView : public View
{
private:
    Border *_border;
    TFT_eSPI *_tft;
    VirtualRTCProvider *_vRTCProvider;
    ClickableItem _items[3];
    SettingViewState _viewState = SettingViewState::IDLE;
    int *_hasBluetoothConnnection;
    int _amountOfSettingsPerPage = 3;
    int _settingsHeight = WatchSettings::get<int>(screenVertical) / _amountOfSettingsPerPage;
    int _verticalPageIndex = 0;
    int _amountOfEditableSettings = 0;
    WatchSetting *_editableSettings = WatchSettings::getEditableSettings(&_amountOfEditableSettings);
    int _editSettingsIndex = -1;

    void _clearCenter();
    void _setClickableItems();
    void _drawSelectionView();
    void _drawEditingView();

public:
    SettingsView() = default;
    ~SettingsView() { _tft->unloadFont(); };

    void init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider, int *hasBluetoothConnnection, int *amountOfActiveViews = nullptr, int *currentViewIndex = nullptr) override;
    void draw(int clearScreen = false) override;
    ViewTypes getViewType() const override;
    int getViewState() const override;
    ClickableItem *getListOfClickableItems(int *arraySize) override;
    void pageDown();
    void pageUp();
    void editSetting(int index);
    void stopEditing();
    void incrementValue();
    void decreaseValue();
};

#endif