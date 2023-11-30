#ifndef TOPIC_VIEW
#define TOPIC_VIEW

#include "View.h"

struct Topic
{
    int id = -1;
    String name = "";
    uint16_t color;
};

enum TopicViewState
{
    IDLE,
    TRACKING,
};

class TopicView : public View
{
private:
    Topic _topic;
    TopicViewState _viewState = TopicViewState::IDLE;
    Border *_border;
    TFT_eSPI *_tft;
    VirtualRTCProvider *_vRTCProvider;
    DateTime *_dateTime;
    DateTime *_trackingDateTime;
    ClickableItem _items[1];
    int *_amountOfActiveViews;
    int *_currentViewIndex;
    int *_hasBluetoothConnnection;

    void _clearCenter();
    void _drawIdle(int clearScreen);
    void _drawTracking(int clearScreen);
    void _setClickableItems();

public:
    TopicView() = default;
    ~TopicView() = default;

    void init(TFT_eSPI *tft, Border *border, VirtualRTCProvider *vRTCProvider, int *hasBluetoothConnnection, int *amountOfActiveViews, int *currentViewIndex) override;
    void draw(int clearScreen = false) override;
    ViewTypes getViewType() const override;
    ClickableItem *getListOfClickableItems(int *arraySize) override;
    void setTopic(Topic topic);
    void startTracking();
    void stopTracking();
};

#endif