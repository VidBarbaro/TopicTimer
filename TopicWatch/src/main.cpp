#include "Arduino.h"
#include "BLEProvider.h"
#include "ScreenProvider.h"
#include "VirtualRTCProvider.h"
#include "FeedbackProvider.h"

BLEProvider bleProvider;
VirtualRTCProvider vrp;
ScreenProvider sp;

void setup()
{
    Serial.begin(115200);
    WatchSettings::initializeSettings();

    bleProvider.init();
    sp.init(&vrp, &bleProvider);

    FeedbackProvider::setVibrationPattern(PatternFactory::createVibrationPattern(WatchSettings::get<int>(vibrationPattern)));
    FeedbackProvider::setSoundPattern(PatternFactory::createSoundPattern(WatchSettings::get<int>(soundPattern)));
}

void loop()
{
    sp.update();
    bleProvider.update();
    FeedbackProvider::update();
}
