#ifndef HOME_VIEW
#define HOME_VIEW

#include "View.h"

class HomeView : public View
{
private:
    Border *_border;
    TFT_eSPI *_tft;
    VirtualRTCProvider *_vRTCProvider;
    DateTime *_dateTime;
    ClickableItem _items[1];
    int *_hasBluetoothConnnection;

    void _clearCenter();
    void _setClickableItems();

public:
    HomeView() = default;
    ~HomeView() { _tft->unloadFont(); };

    void init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider, int *hasBluetoothConnnection, int *amountOfActiveViews = nullptr, int *currentViewIndex = nullptr) override;
    void draw(int clearScreen = false) override;
    ViewTypes getViewType() const override;
    ClickableItem *getListOfClickableItems(int *arraySize) override;
};

#endif