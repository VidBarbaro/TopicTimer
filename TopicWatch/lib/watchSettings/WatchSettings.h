#ifndef WATCH_SETTINGS
#define WATCH_SETTINGS

#include "Arduino.h"
#include "HexHelper.h"

union Value
{
    int intValue;
    uint16_t uint16_tValue;
};

enum WatchSettingType
{
    INT,
    UINT16_T
};

enum WatchSettingNames
{
    screenHorizontal,
    screenVertical,
    amountOfNonTopicViews,
    maxAmountOfViews,
    minimalTrackingMinutes,
    borderSize,
    marginFromBorder,
    textMargin,
    iconSize,
    iconMargin,
    topicTimer_GREEN,
    topicTimer_ORANGE,
    topicTimer_BLUE,
    topicTimer_GRAY,
    topicTimer_BLACK
};

struct WatchSetting
{
    WatchSettingNames name;
    String displayName = "";
    int editable = false;
    WatchSettingType type;
    Value value;
    Value maxValue;
    Value minValue;
};

class WatchSettings
{
private:
    static const int _amountOfSettings = 15;
    static WatchSetting _settings[_amountOfSettings];

    static const uint32_t topicTimer_GREEN_HEX = 0x009688;
    static const uint32_t topicTimer_ORANGE_HEX = 0xFFC107;
    static const uint32_t topicTimer_BLUE_HEX = 0x03A9F4;
    static const uint32_t topicTimer_GRAY_HEX = 0xF5F5F5;
    static const uint32_t topicTimer_BLACK_HEX = 0x333333;

public:
    WatchSettings() = delete;
    ~WatchSettings() = default;

    static void initializeSettings();
    static WatchSetting *getEditableSettings(int *amountOfEditableSettings);

    template <typename T>
    static const T get(int index, bool getMaxValue = false)
    {
        if (index < 0 || index >= _amountOfSettings)
        {
            return T{};
        }

        const WatchSetting &setting = _settings[index];

        switch (setting.type)
        {
        case INT:
            return getMaxValue ? (T)setting.maxValue.intValue : (T)setting.value.intValue;
        case UINT16_T:
            return getMaxValue ? (T)setting.maxValue.uint16_tValue : (T)setting.value.uint16_tValue;
        default:
            return T{};
        }
    }

    template <typename T>
    static const T get(WatchSettingNames name, bool getMaxValue = false)
    {
        for (int i = 0; i < _amountOfSettings; ++i)
        {
            if (_settings[i].name == name)
            {
                return get<T>(i, getMaxValue);
            }
        }

        return T{};
    }

    template <typename T>
    static void set(int index, T newValue)
    {
        if (index < 0 || index >= _amountOfSettings)
        {
            return;
        }

        WatchSetting &setting = _settings[index];

        switch (setting.type)
        {
        case WatchSettingType::INT:
            setting.value.intValue = (int)newValue;
            break;
        case WatchSettingType::UINT16_T:
            setting.value.uint16_tValue = (uint16_t)newValue;
            break;
        default:
            break;
        }
    }

    template <typename T>
    static void set(WatchSettingNames name, T newValue)
    {
        for (int i = 0; i < _amountOfSettings; ++i)
        {
            if (_settings[i].name == name)
            {
                set(i, newValue);
                return;
            }
        }
    }
};

#endif