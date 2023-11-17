#ifndef VIEW_CONTROLLER
#define VIEW_CONTROLLER

#include "Border.h"
#include "TFT_eSPI.h"
#include "View.h"
#include "VirtualRTCProvider.h"
#include "WatchSettings.h"

class ViewController
{
private:
    int _activeViewCount = 0;
    View _allViews[WatchSettings::maxAmountOfViews];
    Border *_border;
    int _currentViewIndex;
    TFT_eSPI *_tft;
    VirtualRTCProvider *_vRTCProvider;
    int _currentViewIsTracking = false;

public:
    ViewController() = default;
    ~ViewController() = default;
    void init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider);
    void home();
    void nextLeft();
    void nextRight();
    void addView();
    void addView(Topic topic);
    void removeView(int viewIndex);
    void drawCurrentView();
    void startTracking();
    void togglePauseTracking();
    void stopTracking();
    int getCurrentViewState();
};

#endif