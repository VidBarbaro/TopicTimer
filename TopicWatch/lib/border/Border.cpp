#include "Border.h"

void Border::init(TFT_eSPI *tft, int height)
{
    _tft = tft;
    _height = height;
}

double Border::_getPrecentage(double progress, double goal)
{
    return (progress / goal) * 100;
}

void Border::clear(uint32_t clearColor)
{
    _tft->fillRect(0, 0, _screenHorizontal, _height, clearColor);                           // draw top
    _tft->fillRect((_screenHorizontal - _height), 0, _height, _screenVertical, clearColor); // draw right
    _tft->fillRect(0, (_screenVertical - _height), _screenHorizontal, _height, clearColor); // draw bottom
    _tft->fillRect(0, 0, _height, _screenVertical, clearColor);                             // draw left
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
        _tft->fillRect(0, 0, totalBorderWidth, _height, color);
    }
    else if (totalBorderWidth <= (_screenHorizontal + _screenVertical))
    {
        _tft->fillRect(0, 0, _screenHorizontal, _height, color); // draw top
        _tft->fillRect((_screenHorizontal - _height), 0, _height, (totalBorderWidth - _screenHorizontal), color);
    }
    else if (totalBorderWidth <= (_screenHorizontal + _screenVertical + _screenHorizontal))
    {
        _tft->fillRect(0, 0, _screenHorizontal, _height, color);                           // draw top
        _tft->fillRect((_screenHorizontal - _height), 0, _height, _screenVertical, color); // draw right
        _tft->fillRect((_screenHorizontal - (totalBorderWidth - _screenHorizontal - _screenVertical)), (_screenVertical - _height), (totalBorderWidth - _screenHorizontal - _screenVertical), _height, color);
    }
    else
    {
        _tft->fillRect(0, 0, _screenHorizontal, _height, color);                           // draw top
        _tft->fillRect((_screenHorizontal - _height), 0, _height, _screenVertical, color); // draw right
        _tft->fillRect(0, (_screenVertical - _height), _screenHorizontal, _height, color); // draw bottom
        _tft->fillRect(0, (_screenVertical - (totalBorderWidth - _screenHorizontal - _screenVertical - _screenHorizontal)), _height, (totalBorderWidth - _screenHorizontal - _screenVertical - _screenHorizontal), color);
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