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
    int *_hasBluetoothConnnection;

    void _clearCenter();

public:
    HomeView() = default;
    ~HomeView() = default;

    void init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider, int *hasBluetoothConnnection, int *amountOfActiveViews = nullptr, int *currentViewIndex = nullptr) override;
    void draw(int clearScreen = false) override;
    ViewTypes getViewType() const override;
};

#endif