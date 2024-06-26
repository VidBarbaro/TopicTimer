#include "WatchSettings.h"

WatchSetting WatchSettings::_settings[AMOUNT_OF_SETTINGS];

void WatchSettings::initializeSettings()
{
    _settings[0].name = screenHorizontal;
    _settings[0].type = WatchSettingType::INT;
    set<int>(screenHorizontal, 320);

    _settings[1].name = screenVertical;
    _settings[1].type = WatchSettingType::INT;
    set<int>(screenVertical, 170);

    _settings[2].name = amountOfNonTopicViews;
    _settings[2].type = WatchSettingType::INT;
    set<int>(amountOfNonTopicViews, 2);

    _settings[3].name = maxAmountOfViews;
    _settings[3].type = WatchSettingType::INT;
    set<int>(maxAmountOfViews, 100 + get<int>(amountOfNonTopicViews)); // IF THIS EVER CHANGES DON'T FORGET TO CHANGE ViewController.h

    _settings[4].name = minimalTrackingMinutes;
    _settings[4].type = WatchSettingType::INT;
    _settings[4].editable = true;
    _settings[4].displayName = "Minimal tracking minutes";
    _settings[4].type = WatchSettingType::INT;
    _settings[4].maxValue.intValue = 1;
    _settings[4].minValue.intValue = 0;
    set<int>(minimalTrackingMinutes, 1);

    _settings[5].name = borderSize;
    _settings[5].type = WatchSettingType::INT;
    _settings[5].editable = true;
    _settings[5].displayName = "Border size";
    _settings[5].maxValue.intValue = 10;
    _settings[5].minValue.intValue = 0;
    set<int>(borderSize, 5);

    _settings[6].name = marginFromBorder;
    _settings[6].type = WatchSettingType::INT;
    set<int>(marginFromBorder, 9);

    _settings[7].name = textMargin;
    _settings[7].type = WatchSettingType::INT;
    set<int>(textMargin, 17);

    _settings[8].name = iconSize;
    _settings[8].type = WatchSettingType::INT;
    set<int>(iconSize, 35);

    _settings[9].name = iconSizeSmall;
    _settings[9].type = WatchSettingType::INT;
    set<int>(iconSizeSmall, 25);

    _settings[10].name = iconMargin;
    _settings[10].type = WatchSettingType::INT;
    set<int>(iconMargin, 5);

    _settings[11].name = topicTimer_GREEN;
    _settings[11].type = WatchSettingType::UINT16_T;
    set<uint16_t>(topicTimer_GREEN, HexHelper::convertTo565(WatchSettings::topicTimer_GREEN_HEX));

    _settings[12].name = topicTimer_ORANGE;
    _settings[12].type = WatchSettingType::UINT16_T;
    set<uint16_t>(topicTimer_ORANGE, HexHelper::convertTo565(WatchSettings::topicTimer_ORANGE_HEX));

    _settings[13].name = topicTimer_BLUE;
    _settings[13].type = WatchSettingType::UINT16_T;
    set<uint16_t>(topicTimer_BLUE, HexHelper::convertTo565(WatchSettings::topicTimer_BLUE_HEX));

    _settings[14].name = topicTimer_GRAY;
    _settings[14].type = WatchSettingType::UINT16_T;
    set<uint16_t>(topicTimer_GRAY, HexHelper::convertTo565(WatchSettings::topicTimer_GRAY_HEX));

    _settings[15].name = topicTimer_BLACK;
    _settings[15].type = WatchSettingType::UINT16_T;
    set<uint16_t>(topicTimer_BLACK, HexHelper::convertTo565(WatchSettings::topicTimer_BLACK_HEX));

    _settings[16].name = vibrationLevel;
    _settings[16].type = WatchSettingType::INT;
    _settings[16].editable = true;
    _settings[16].displayName = "Vibration level";
    _settings[16].maxValue.intValue = 10;
    _settings[16].minValue.intValue = 0;
    set<int>(vibrationLevel, 5);

    _settings[17].name = vibrationPattern;
    _settings[17].type = WatchSettingType::INT;
    _settings[17].editable = true;
    _settings[17].displayName = "Vibration pattern";
    _settings[17].maxValue.intValue = 5;
    _settings[17].minValue.intValue = 1;
    set<int>(vibrationPattern, 1);

    _settings[18].name = soundLevel;
    _settings[18].type = WatchSettingType::INT;
    _settings[18].editable = true;
    _settings[18].displayName = "Sound level";
    _settings[18].maxValue.intValue = 10;
    _settings[18].minValue.intValue = 0;
    set<int>(soundLevel, 5);

    _settings[19].name = soundPattern;
    _settings[19].type = WatchSettingType::INT;
    _settings[19].editable = true;
    _settings[19].displayName = "Sound pattern";
    _settings[19].maxValue.intValue = 5;
    _settings[19].minValue.intValue = 1;
    set<int>(soundPattern, 1);

    _settings[20].name = vibrationMotorPin;
    _settings[20].type = WatchSettingType::INT;
    set<int>(vibrationMotorPin, 2);

    _settings[21].name = buzzerPin;
    _settings[21].type = WatchSettingType::INT;
    set<int>(buzzerPin, 3);
}

WatchSetting *WatchSettings::getEditableSettings(int *amountOfEditableSettings)
{
    WatchSetting *editableSettings = new WatchSetting[AMOUNT_OF_SETTINGS];
    int count = 0;

    for (int i = 0; i < AMOUNT_OF_SETTINGS; ++i)
    {
        if (_settings[i].editable)
        {
            editableSettings[count++] = _settings[i];
        }
    }

    *amountOfEditableSettings = count;
    return editableSettings;
}