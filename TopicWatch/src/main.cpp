#include "Arduino.h"
#include "BLEProvider.h"
#include "ScreenProvider.h"
#include "VirtualRTCProvider.h"
#include "pwmWrite.h"
#include "FeedbackProvider.h"

BLEProvider bleProvider;
VirtualRTCProvider vrp;
ScreenProvider sp;
// Pwm pwm;

void setup()
{
    Serial.begin(115200);
    WatchSettings::initializeSettings();

    bleProvider.init();
    sp.init(&vrp, &bleProvider);

    // EXAMPLE VIBRATOR MOTOR CODE
    // pwm.write(2, 100);
    // delay(1000);
    // pwm.write(2, 255);
}

void loop()
{
    sp.update();
    bleProvider.update();
    FeedbackProvider::update();
}
