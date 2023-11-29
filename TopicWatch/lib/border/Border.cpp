#include "Border.h"

void Border::init(TFT_eSPI *tft)
{
    _tft = tft;
}

double Border::_getPrecentage(double progress, double goal)
{
    return (progress / goal) * 100;
}

void Border::clear(uint32_t clearColor)
{
    _tft->fillRect(0, 0, WatchSettings::screenHorizontal, WatchSettings::borderSize, clearColor);                                                           // draw top
    _tft->fillRect((WatchSettings::screenHorizontal - WatchSettings::borderSize), 0, WatchSettings::borderSize, WatchSettings::screenVertical, clearColor); // draw right
    _tft->fillRect(0, (WatchSettings::screenVertical - WatchSettings::borderSize), WatchSettings::screenHorizontal, WatchSettings::borderSize, clearColor); // draw bottom
    _tft->fillRect(0, 0, WatchSettings::borderSize, WatchSettings::screenVertical, clearColor);                                                             // draw left
}

void Border::set(double precent)
{
    Border::set(precent, _defaultColor);
}

void Border::set(double precent, uint32_t color)
{
    double totalBorderWidth = (precent / 100) * 980;

    if (totalBorderWidth <= WatchSettings::screenHorizontal)
    {
        _tft->fillRect(0, 0, totalBorderWidth, WatchSettings::borderSize, color);
    }
    else if (totalBorderWidth <= (WatchSettings::screenHorizontal + WatchSettings::screenVertical))
    {
        _tft->fillRect(0, 0, WatchSettings::screenHorizontal, WatchSettings::borderSize, color); // draw top
        _tft->fillRect((WatchSettings::screenHorizontal - WatchSettings::borderSize), 0, WatchSettings::borderSize, (totalBorderWidth - WatchSettings::screenHorizontal), color);
    }
    else if (totalBorderWidth <= (WatchSettings::screenHorizontal + WatchSettings::screenVertical + WatchSettings::screenHorizontal))
    {
        _tft->fillRect(0, 0, WatchSettings::screenHorizontal, WatchSettings::borderSize, color);                                                           // draw top
        _tft->fillRect((WatchSettings::screenHorizontal - WatchSettings::borderSize), 0, WatchSettings::borderSize, WatchSettings::screenVertical, color); // draw right
        _tft->fillRect((WatchSettings::screenHorizontal - (totalBorderWidth - WatchSettings::screenHorizontal - WatchSettings::screenVertical)), (WatchSettings::screenVertical - WatchSettings::borderSize), (totalBorderWidth - WatchSettings::screenHorizontal - WatchSettings::screenVertical), WatchSettings::borderSize, color);
    }
    else
    {
        _tft->fillRect(0, 0, WatchSettings::screenHorizontal, WatchSettings::borderSize, color);                                                           // draw top
        _tft->fillRect((WatchSettings::screenHorizontal - WatchSettings::borderSize), 0, WatchSettings::borderSize, WatchSettings::screenVertical, color); // draw right
        _tft->fillRect(0, (WatchSettings::screenVertical - WatchSettings::borderSize), WatchSettings::screenHorizontal, WatchSettings::borderSize, color); // draw bottom
        _tft->fillRect(0, (WatchSettings::screenVertical - (totalBorderWidth - WatchSettings::screenHorizontal - WatchSettings::screenVertical - WatchSettings::screenHorizontal)), WatchSettings::borderSize, (totalBorderWidth - WatchSettings::screenHorizontal - WatchSettings::screenVertical - WatchSettings::screenHorizontal), color);
    }
}

void Border::setWithGoal(double progress, double goal)
{
    Border::set(_getPrecentage(progress, goal), _defaultColor);
}

void Border::setWithGoal(double progress, double goal, uint32_t color)
{
    Border::set(_getPrecentage(progress, goal), color);
}