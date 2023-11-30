#ifndef HEX_HELPER
#define HEX_HELPER

#include "Arduino.h"

class HexHelper
{
public:
    HexHelper() = delete;
    ~HexHelper() = default;

    static uint16_t convertHexTo565(uint32_t hexColor)
    {
        uint8_t red = (hexColor >> 16) & 0xFF;
        uint8_t green = (hexColor >> 8) & 0xFF;
        uint8_t blue = hexColor & 0xFF;

        uint16_t color565 = ((red & 0xF8) << 8) | ((green & 0xFC) << 3) | (blue >> 3);

        return color565;
    }
};

#endif