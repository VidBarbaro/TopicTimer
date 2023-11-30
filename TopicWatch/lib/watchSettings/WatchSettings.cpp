#include "WatchSettings.h"

WatchSetting WatchSettings::_settings[_amountOfSettings];

void WatchSettings::initializeSettings()
{
    _settings[0].name = "screenHorizontal";
    _settings[0].type = WatchSettingType::INT;
    set<int>(String("screenHorizontal"), 320);

    _settings[1].name = "screenVertical";
    _settings[1].type = WatchSettingType::INT;
    set<int>(String("screenVertical"), 170);

    _settings[2].name = "amountOfNonTopicViews";
    _settings[2].type = WatchSettingType::INT;
    set<int>(String("amountOfNonTopicViews"), 2);

    _settings[3].name = "maxAmountOfViews";
    _settings[3].type = WatchSettingType::INT;
    set<int>(String("maxAmountOfViews"), 100 + get<int>("amountOfNonTopicViews")); // IF THIS EVERY CHANGES DON'T FORGET TO CHANGE ViewController.h

    _settings[4].name = "minimalTrackingMinutes";
    _settings[4].type = WatchSettingType::INT;
    set<int>(String("minimalTrackingMinutes"), 5);

    _settings[5].name = "borderSize";
    _settings[5].type = WatchSettingType::INT;
    _settings[5].editable = true;
    set<int>(String("borderSize"), 4);

    _settings[6].name = "marginFromBorder";
    _settings[6].type = WatchSettingType::INT;
    set<int>(String("marginFromBorder"), 9);

    _settings[7].name = "textMargin";
    _settings[7].type = WatchSettingType::INT;
    set<int>(String("textMargin"), 17);

    _settings[8].name = "iconSize";
    _settings[8].type = WatchSettingType::INT;
    set<int>(String("iconSize"), 35);

    _settings[9].name = "iconMargin";
    _settings[9].type = WatchSettingType::INT;
    set<int>(String("iconMargin"), 5);

    _settings[10].name = "topicTimer_GREEN";
    _settings[10].type = WatchSettingType::UINT16_T;
    set<uint16_t>(String("topicTimer_GREEN"), HexHelper::convertHexTo565(WatchSettings::topicTimer_GREEN_HEX));

    _settings[11].name = "topicTimer_ORANGE";
    _settings[11].type = WatchSettingType::UINT16_T;
    set<uint16_t>(String("topicTimer_ORANGE"), HexHelper::convertHexTo565(WatchSettings::topicTimer_ORANGE_HEX));

    _settings[12].name = "topicTimer_BLUE";
    _settings[12].type = WatchSettingType::UINT16_T;
    set<uint16_t>(String("topicTimer_BLUE"), HexHelper::convertHexTo565(WatchSettings::topicTimer_BLUE_HEX));

    _settings[13].name = "topicTimer_GRAY";
    _settings[13].type = WatchSettingType::UINT16_T;
    set<uint16_t>(String("topicTimer_GRAY"), HexHelper::convertHexTo565(WatchSettings::topicTimer_GRAY_HEX));

    _settings[14].name = "topicTimer_BLACK";
    _settings[14].type = WatchSettingType::UINT16_T;
    set<uint16_t>(String("topicTimer_BLACK"), HexHelper::convertHexTo565(WatchSettings::topicTimer_BLACK_HEX));
}
