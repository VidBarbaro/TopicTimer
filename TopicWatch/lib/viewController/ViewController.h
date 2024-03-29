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

#define MAX_VIEWS 102

class ViewController
{
private:
    static View *_views[MAX_VIEWS];
    static Border *_border;
    static TFT_eSPI *_tft;
    static VirtualRTCProvider *_vRTCProvider;
    static int _hasBluetoothConnnection;
    static int _activeViewCount;
    static int _viewIndex;
    static int _viewListIsBeingUpdated;
    static int _clearScreen;

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
    static void addTopic(Topic topic);
    static void editTopic(int index, Topic topic);
    static void removeTopic(int index);
    static void removeAllTopics();
    void drawCurrentView(int clearScreen = false);
    void startTracking();
    void togglePauseTracking();
    void stopTracking();
    void stopEditing();
    int getCurrentViewState();
    int getCurrentViewType();
    void setHasBluetoothConnection();
    void setHasNoBluetoothConnection();
};

#endif