#ifndef VIEW
#define VIEW

#include "Arduino.h"
#include "Border.h"
#include "StringHelper.h"
#include "TFT_eSPI.h"
#include "VirtualRTCProvider.h"
#include "WatchSettings.h"

struct Topic
{
    int id = -1;
    String name = "";
    uint32_t color;
};

class View
{
private:
    int _initialized = false;
    Topic _topic;
    enum ViewState
    {
        IDLE,
        TRACKING,
    };
    ViewState viewState = ViewState::IDLE;
    Border *_border;
    TFT_eSPI *_tft;
    VirtualRTCProvider *_vRTCProvider;
    DateTime *_dateTime;
    int *_amountOfActiveViews;
    int *_currentViewIndex;

    void _clearCenter();
    void _drawHomeView(int clearScreen);
    void _drawIdle(int clearScreen);
    void _drawTracking(int clearScreen);

public:
    View() = default;
    ~View() = default;
    void init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider, int *amountOfActiveViews, int *currentViewIndex);
    void init(Topic topic, TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider, int *amountOfActiveViews, int *currentViewIndex);
    int isInitialized();
    void draw(int clearScreen = false);
};

#endif