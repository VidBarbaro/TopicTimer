#include "WatchSettings.h"

uint16_t convertHexTo565(uint32_t hexColor)
{
    uint8_t red = (hexColor >> 16) & 0xFF;
    uint8_t green = (hexColor >> 8) & 0xFF;
    uint8_t blue = hexColor & 0xFF;

    uint16_t color565 = ((red & 0xF8) << 8) | ((green & 0xFC) << 3) | (blue >> 3);

    return color565;
}

uint16_t WatchSettings::topicTimer_GREEN = convertHexTo565(WatchSettings::topicTimer_GREEN_HEX);
uint16_t WatchSettings::topicTimer_ORANGE = convertHexTo565(WatchSettings::topicTimer_ORANGE_HEX);
uint16_t WatchSettings::topicTimer_BLUE = convertHexTo565(WatchSettings::topicTimer_BLUE_HEX);
uint16_t WatchSettings::topicTimer_GRAY = convertHexTo565(WatchSettings::topicTimer_GRAY_HEX);
uint16_t WatchSettings::topicTimer_BLACK = convertHexTo565(WatchSettings::topicTimer_BLACK_HEX);
