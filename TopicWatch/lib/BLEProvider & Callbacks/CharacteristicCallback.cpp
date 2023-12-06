#include "CharacteristicCallbacks.h"

CharacteristicCallbacks::CharacteristicCallbacks(void *provider)
{
    _provider = provider;
}

void CharacteristicCallbacks::onRead(NimBLECharacteristic *pCharacteristic)
{
    Serial.print(pCharacteristic->getUUID().toString().c_str());
    Serial.print(": onRead(), value: ");
    Serial.println(pCharacteristic->getValue().c_str());
}

void CharacteristicCallbacks::onWrite(NimBLECharacteristic *pCharacteristic)
{
    Serial.print(pCharacteristic->getUUID().toString().c_str());
    Serial.print(": onWrite(), value: ");
    Serial.println(pCharacteristic->getValue().c_str());
    handleMessage(pCharacteristic->getValue().c_str(), pCharacteristic);
}

/// @brief OnNotify also handles onIndicate (Indicate is with ACK, Notify is without ACK)
/// @param pCharacteristic
void CharacteristicCallbacks::onNotify(NimBLECharacteristic *pCharacteristic)
{
    Serial.print(pCharacteristic->getUUID().toString().c_str());
    Serial.print(": onNotify(), value: ");
    Serial.println(pCharacteristic->getValue().c_str());
}

/// @brief
/// @param message
/// @return TRUE if succesfull OR FALSE for failure
bool CharacteristicCallbacks::handleMessage(String message, NimBLECharacteristic *pCharacteristic)
{
    BLEProvider *bleProvider = (BLEProvider *)_provider;
    if (message == NULL || message.length() == 0)
    {
        Serial.println("Message is invalid");
        return false;
    }
    // JSON string is double serialized, to it needs twice deserialized
    DynamicJsonDocument doc(2048);
    DeserializationError error = deserializeJson(doc, message);

    Serial.print("Command found: ");
    Serial.println(doc["command"].as<String>());
    Serial.print("[RECEIVED]: ");
    serializeJson(doc, Serial);
    if (error == DeserializationError::Ok)
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
            return true;
        }
        else if (doc["command"] == "setTopics")
        {
            // do something with the received topic
            return true;
        }
        else
        {
            // Unknown message command found
            Serial.println("Unknown message command found");
            return false;
        }
    }
    else
    {
        if (error = DeserializationError::NoMemory)
        {
            Serial.println("Json doc too small (NoMemory)");
            return false;
        }

        Serial.println("Unknown error deserialzing Json");
        return false;
    }
    return true;
}