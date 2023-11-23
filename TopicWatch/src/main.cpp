#include "Arduino.h"
#include "BLEProvider.h"
#include "ScreenProvider.h"
#include "VirtualRTCProvider.h"

BLEProvider bleProvider;
VirtualRTCProvider vrp;
ScreenProvider sp;

void setup()
{
    sp.init(&vrp);
    bleProvider.init(&sp);
}

void loop()
{
    sp.update();
}
