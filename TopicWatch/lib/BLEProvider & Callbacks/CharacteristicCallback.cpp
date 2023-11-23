#include "CharacteristicCallbacks.h"

CharacteristicCallbacks::CharacteristicCallbacks(void* provider)
{
    _provider = provider;
}

void CharacteristicCallbacks::onRead(NimBLECharacteristic* pCharacteristic)
{
    Serial.print(pCharacteristic->getUUID().toString().c_str());
    Serial.print(": onRead(), value: ");
    Serial.println(pCharacteristic->getValue().c_str());
}

void CharacteristicCallbacks::onWrite(NimBLECharacteristic* pCharacteristic)
{
    Serial.print(pCharacteristic->getUUID().toString().c_str());
    Serial.print(": onWrite(), value: ");
    Serial.println(pCharacteristic->getValue().c_str());
    handleMessage(pCharacteristic->getValue().c_str());
}

/// @brief 
/// @param message 
/// @return TRUE if succesfull OR FAlSE for failure 
bool CharacteristicCallbacks::handleMessage(String message)
{
    Serial.println("message: ");
    Serial.println(message);
    BLEProvider* bleProvider = (BLEProvider*)_provider;
    if(message == NULL || message == " ")
    {
        Serial.println("Message is fucked niffo");
        return false;
    }
    //JSON string is double serialized, to it needs twice deserialized
    StaticJsonDocument<512> temp, doc;
    DeserializationError error = deserializeJson(temp, message);
    error = deserializeJson(doc, temp.as<const char*>());

    Serial.print("[RECEIVED]: ");
    serializeJson(doc, Serial);
    if(error == DeserializationError::Ok)
    {
        if (doc["command"] == "setTime")
        {
            Serial.println("Command found");
            int h = doc["data"]["time"]["hours"];
            int m = doc["data"]["time"]["minutes"];
            int s = doc["data"]["time"]["seconds"];

            int y = doc["data"]["date"]["year"];
            int mo = doc["data"]["date"]["month"];
            int d = doc["data"]["date"]["day"];

            VirtualRTCProvider::setTime(h, m, s, y, mo, d);
        }
        else
        {
            //Unknown message command found
            Serial.println("Unknown message command found");
            return false;
        }
    }
    else
    {
        if (error = DeserializationError::NoMemory)
        {
            Serial.println("Json doc too small");
        }

        Serial.println("error deserialzing Json");
        return false;
    }
    return true;
}