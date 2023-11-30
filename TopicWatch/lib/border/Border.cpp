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
    _tft->fillRect(0, 0, WatchSettings::get<int>(String("screenHorizontal")), WatchSettings::get<int>(String("borderSize")), clearColor);                                                                                                   // draw top
    _tft->fillRect((WatchSettings::get<int>(String("screenHorizontal")) - WatchSettings::get<int>(String("borderSize"))), 0, WatchSettings::get<int>(String("borderSize")), WatchSettings::get<int>(String("screenVertical")), clearColor); // draw right
    _tft->fillRect(0, (WatchSettings::get<int>(String("screenVertical")) - WatchSettings::get<int>(String("borderSize"))), WatchSettings::get<int>(String("screenHorizontal")), WatchSettings::get<int>(String("borderSize")), clearColor); // draw bottom
    _tft->fillRect(0, 0, WatchSettings::get<int>(String("borderSize")), WatchSettings::get<int>(String("screenVertical")), clearColor);                                                                                                     // draw left
}

void Border::set(double precent)
{
    Border::set(precent, _defaultColor);
}

void Border::set(double precent, uint32_t color)
{
    double totalBorderWidth = (precent / 100) * 980;

    if (totalBorderWidth <= WatchSettings::get<int>(String("screenHorizontal")))
    {
        _tft->fillRect(0, 0, totalBorderWidth, WatchSettings::get<int>(String("borderSize")), color);
    }
    else if (totalBorderWidth <= (WatchSettings::get<int>(String("screenHorizontal")) + WatchSettings::get<int>(String("screenVertical"))))
    {
        _tft->fillRect(0, 0, WatchSettings::get<int>(String("screenHorizontal")), WatchSettings::get<int>(String("borderSize")), color); // draw top
        _tft->fillRect((WatchSettings::get<int>(String("screenHorizontal")) - WatchSettings::get<int>(String("borderSize"))), 0, WatchSettings::get<int>(String("borderSize")), (totalBorderWidth - WatchSettings::get<int>(String("screenHorizontal"))), color);
    }
    else if (totalBorderWidth <= (WatchSettings::get<int>(String("screenHorizontal")) + WatchSettings::get<int>(String("screenVertical")) + WatchSettings::get<int>(String("screenHorizontal"))))
    {
        _tft->fillRect(0, 0, WatchSettings::get<int>(String("screenHorizontal")), WatchSettings::get<int>(String("borderSize")), color);                                                                                                   // draw top
        _tft->fillRect((WatchSettings::get<int>(String("screenHorizontal")) - WatchSettings::get<int>(String("borderSize"))), 0, WatchSettings::get<int>(String("borderSize")), WatchSettings::get<int>(String("screenVertical")), color); // draw right
        _tft->fillRect((WatchSettings::get<int>(String("screenHorizontal")) - (totalBorderWidth - WatchSettings::get<int>(String("screenHorizontal")) - WatchSettings::get<int>(String("screenVertical")))), (WatchSettings::get<int>(String("screenVertical")) - WatchSettings::get<int>(String("borderSize"))), (totalBorderWidth - WatchSettings::get<int>(String("screenHorizontal")) - WatchSettings::get<int>(String("screenVertical"))), WatchSettings::get<int>(String("borderSize")), color);
    }
    else
    {
        _tft->fillRect(0, 0, WatchSettings::get<int>(String("screenHorizontal")), WatchSettings::get<int>(String("borderSize")), color);                                                                                                   // draw top
        _tft->fillRect((WatchSettings::get<int>(String("screenHorizontal")) - WatchSettings::get<int>(String("borderSize"))), 0, WatchSettings::get<int>(String("borderSize")), WatchSettings::get<int>(String("screenVertical")), color); // draw right
        _tft->fillRect(0, (WatchSettings::get<int>(String("screenVertical")) - WatchSettings::get<int>(String("borderSize"))), WatchSettings::get<int>(String("screenHorizontal")), WatchSettings::get<int>(String("borderSize")), color); // draw bottom
        _tft->fillRect(0, (WatchSettings::get<int>(String("screenVertical")) - (totalBorderWidth - WatchSettings::get<int>(String("screenHorizontal")) - WatchSettings::get<int>(String("screenVertical")) - WatchSettings::get<int>(String("screenHorizontal")))), WatchSettings::get<int>(String("borderSize")), (totalBorderWidth - WatchSettings::get<int>(String("screenHorizontal")) - WatchSettings::get<int>(String("screenVertical")) - WatchSettings::get<int>(String("screenHorizontal"))), color);
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