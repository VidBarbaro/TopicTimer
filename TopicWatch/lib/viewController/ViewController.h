#ifndef VIEW_CONTROLLER
#define VIEW_CONTROLLER

#include "Arduino.h"
#include "Border.h"
#include "TFT_eSPI.h"
#include "View.h"
#include "HomeView.h"
#include "TopicView.h"
#include "SettingsView.h"
#include "VirtualRTCProvider.h"
#include "WatchSettings.h"

class ViewController
{
private:
    View *_views[102];
    Border *_border;
    TFT_eSPI *_tft;
    VirtualRTCProvider *_vRTCProvider;
    int _currentViewIsTracking = false;
    int _hasBluetoothConnnection = false;
    int _activeViewCount = 0;
    int _viewIndex = 1;

public:
    ViewController() = default;
    ~ViewController();
    void init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider);
    void click(int x, int y);
    void home();
    void settings();
    void nextLeft();
    void nextRight();
    void nextUp();
    void nextDown();
    void addView(Topic topic);
    void removeView(int viewIndex);
    void drawCurrentView(int clearScreen = false);
    void startTracking();
    void togglePauseTracking();
    void stopTracking();
    int getCurrentViewTrackingState();
    void setHasBluetoothConnection();
    void setHasNoBluetoothConnection();
};

#endif