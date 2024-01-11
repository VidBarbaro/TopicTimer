#include "StringHelper.h"

String StringHelper::padZeroLeft(String value)
{
    String stringValue = String(value);

    if (stringValue.length() < 2)
    {
        stringValue = "0" + stringValue;
    }

    return stringValue;
}
