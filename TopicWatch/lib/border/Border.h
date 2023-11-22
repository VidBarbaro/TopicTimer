#ifndef BORDER
#define BORDER

#include "Arduino.h"
#include "TFT_eSPI.h"
#include "WatchSettings.h"

class Border
{
private:
    TFT_eSPI *_tft;
    uint32_t _defaultColor = 0xFFFFFF;
    int _screenCircumference = 980;
    int _screenHorizontal = 320;
    int _screenVertical = 170;

    double _getPrecentage(double progress, double goal);

public:
    Border() = default;
    ~Border() = default;
    void init(TFT_eSPI *tft);
    void clear(uint32_t clearColor);
    void set(double precent);
    void set(double precent, uint32_t color);
    void setWithGoal(double progress, double goal);
    void setWithGoal(double progress, double goal, uint32_t color);
    int getHeight();
};

#endif