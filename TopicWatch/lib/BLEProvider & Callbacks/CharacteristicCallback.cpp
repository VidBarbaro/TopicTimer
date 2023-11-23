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
    StaticJsonDocument<400> doc;
    DeserializationError error = deserializeJson(doc, message);

    if(error == DeserializationError::Ok)
    {
        JsonObject root = doc.as<JsonObject>();

        for (JsonPair kv : root)
        {
            Serial.println(kv.key().c_str());
        }

        if (doc["command"] == "setTime")
        {
            Serial.println("Command found");
            int h = doc["data"]["time"]["hours"];
            int m = doc["data"]["time"]["minutes"];
            int s = doc["data"]["time"]["seconds"];

            Serial.println(String(h) + " " + String(m) + " " + String(s));

            if (bleProvider->setTimeCallback != nullptr)
            {
                bleProvider->setTimeCallback(0, 0, 0, 0, 0, 0);
            }
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