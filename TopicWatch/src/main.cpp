#include "Arduino.h"
#include "BLEProvider.h"
#include "ScreenProvider.h"
#include "VirtualRTCProvider.h"

BLEProvider bleProvider;
VirtualRTCProvider vrp;
ScreenProvider sp;

void setup()
{
    WatchSettings::initializeSettings();

    bleProvider.init();
    sp.init(&vrp, &bleProvider);
}

void loop()
{
    sp.update();
}
