#ifndef BORDER
#define BORDER

#include "Arduino.h"
#include "TFT_eSPI.h"
#include "WatchSettings.h"

class Border
{
private:
    TFT_eSPI *_tft;
    uint16_t _defaultColor = TFT_WHITE;
    int _screenCircumference = (WatchSettings::get<int>(screenHorizontal) * 2) + (WatchSettings::get<int>(screenVertical) * 2);

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
};

#endif