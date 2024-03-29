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
    iconSizeSmall,
    iconMargin,
    topicTimer_GREEN,
    topicTimer_ORANGE,
    topicTimer_BLUE,
    topicTimer_GRAY,
    topicTimer_BLACK,
    vibrationLevel,
    vibrationPattern,
    soundLevel,
    soundPattern,
    vibrationMotorPin,
    buzzerPin,
    AMOUNT_OF_SETTINGS // MAKE SURE THIS IS ALWAYS THE LAST ENUM
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
    static WatchSetting _settings[AMOUNT_OF_SETTINGS];

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

    /*
     * Get a watch setting
     *
     * @param name The name of the setting defined by WatchSettingNames
     * @param whichValue -1 == min value, 0 = value, 1 = max value
     */
    template <typename T>
    static const T get(int index, int whichValue = 0)
    {
        if (index < 0 || index >= AMOUNT_OF_SETTINGS)
        {
            return T{};
        }

        const WatchSetting &setting = _settings[index];

        switch (setting.type)
        {
        case INT:
            return whichValue == 1 ? (T)setting.maxValue.intValue : whichValue == 0 ? (T)setting.value.intValue
                                                                                    : (T)setting.minValue.intValue;
        case UINT16_T:
            return whichValue == 1 ? (T)setting.maxValue.uint16_tValue : whichValue == 0 ? (T)setting.value.uint16_tValue
                                                                                         : (T)setting.minValue.uint16_tValue;
        default:
            return T{};
        }
    }

    /*
     * Get a watch setting
     *
     * @param name The name of the setting defined by WatchSettingNames
     * @param whichValue -1 == min value, 0 = value, 1 = max value
     */
    template <typename T>
    static const T get(WatchSettingNames name, int whichValue = 0)
    {
        for (int i = 0; i < AMOUNT_OF_SETTINGS; ++i)
        {
            if (_settings[i].name == name)
            {
                return get<T>(i, whichValue);
            }
        }

        return T{};
    }

    template <typename T>
    static void set(int index, T newValue)
    {
        if (index < 0 || index >= AMOUNT_OF_SETTINGS)
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
        for (int i = 0; i < AMOUNT_OF_SETTINGS; ++i)
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