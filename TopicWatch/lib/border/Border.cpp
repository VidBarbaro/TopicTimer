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
    _tft->fillRect(0, 0, _screenHorizontal, WatchSettings::borderSize, clearColor);                                             // draw top
    _tft->fillRect((_screenHorizontal - WatchSettings::borderSize), 0, WatchSettings::borderSize, _screenVertical, clearColor); // draw right
    _tft->fillRect(0, (_screenVertical - WatchSettings::borderSize), _screenHorizontal, WatchSettings::borderSize, clearColor); // draw bottom
    _tft->fillRect(0, 0, WatchSettings::borderSize, _screenVertical, clearColor);                                               // draw left
}

void Border::set(double precent)
{
    Border::set(precent, _defaultColor);
}

void Border::set(double precent, uint32_t color)
{
    double totalBorderWidth = (precent / 100) * 980;

    if (totalBorderWidth <= _screenHorizontal)
    {
        _tft->fillRect(0, 0, totalBorderWidth, WatchSettings::borderSize, color);
    }
    else if (totalBorderWidth <= (_screenHorizontal + _screenVertical))
    {
        _tft->fillRect(0, 0, _screenHorizontal, WatchSettings::borderSize, color); // draw top
        _tft->fillRect((_screenHorizontal - WatchSettings::borderSize), 0, WatchSettings::borderSize, (totalBorderWidth - _screenHorizontal), color);
    }
    else if (totalBorderWidth <= (_screenHorizontal + _screenVertical + _screenHorizontal))
    {
        _tft->fillRect(0, 0, _screenHorizontal, WatchSettings::borderSize, color);                                             // draw top
        _tft->fillRect((_screenHorizontal - WatchSettings::borderSize), 0, WatchSettings::borderSize, _screenVertical, color); // draw right
        _tft->fillRect((_screenHorizontal - (totalBorderWidth - _screenHorizontal - _screenVertical)), (_screenVertical - WatchSettings::borderSize), (totalBorderWidth - _screenHorizontal - _screenVertical), WatchSettings::borderSize, color);
    }
    else
    {
        _tft->fillRect(0, 0, _screenHorizontal, WatchSettings::borderSize, color);                                             // draw top
        _tft->fillRect((_screenHorizontal - WatchSettings::borderSize), 0, WatchSettings::borderSize, _screenVertical, color); // draw right
        _tft->fillRect(0, (_screenVertical - WatchSettings::borderSize), _screenHorizontal, WatchSettings::borderSize, color); // draw bottom
        _tft->fillRect(0, (_screenVertical - (totalBorderWidth - _screenHorizontal - _screenVertical - _screenHorizontal)), WatchSettings::borderSize, (totalBorderWidth - _screenHorizontal - _screenVertical - _screenHorizontal), color);
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