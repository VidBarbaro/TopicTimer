#ifndef SETTINGS_VIEW
#define SETTIGNS_VIEW

#include "View.h"

class SettingsView : public View
{
private:
    Border *_border;
    TFT_eSPI *_tft;
    VirtualRTCProvider *_vRTCProvider;
    int *_hasBluetoothConnnection;
    ClickableItem _items[1];

    void _clearCenter();
    void _setClickableItems();

public:
    SettingsView() = default;
    ~SettingsView() = default;

    void init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider, int *hasBluetoothConnnection, int *amountOfActiveViews = nullptr, int *currentViewIndex = nullptr) override;
    void draw(int clearScreen = false) override;
    ViewTypes getViewType() const override;
    ClickableItem *getListOfClickableItems(int *arraySize) override;
};

#endif