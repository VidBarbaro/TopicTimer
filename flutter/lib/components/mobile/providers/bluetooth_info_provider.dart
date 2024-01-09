import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/ble_messages.dart';
import 'package:topictimer_flutter_application/components/mobile/models/topic_model.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/tracked_times_provider.dart';

class BluetoothInfoProvider with ChangeNotifier {
  static DiscoveredDevice? _device;

  static const String _baseUUID = '0000-1000-8000-00805f9b34fb';
  static const String _bleUuidServiceTime = '961db84e-$_baseUUID';
  static const String _bleUuidServiceTopic = '961dbf38-$_baseUUID';

  static const String _bleUuidCharacteristicTime = '961dc0dc-$_baseUUID';
  static const String _bleUuidCharacteristicTopic = '961dc24e-$_baseUUID';

  static final _flutterReactiveBle = FlutterReactiveBle();

  static bool _bluetoothIsEnabled = false;
  static bool _connected = false;

  static StreamSubscription<DiscoveredDevice>? _scanListener;
  static StreamSubscription<BleStatus>? _statusListener;
  static StreamSubscription<ConnectionStateUpdate>? _connectionListener;

  static StreamSubscription<List<int>>? _timeCharacteristicListener;
  static StreamSubscription<List<int>>? _topicCharacteristicListener;
  static QualifiedCharacteristic? _timeCharacteristic;
  static QualifiedCharacteristic? _topicCharacteristic;

  void setConnectionState(bool isConnected) {
    _connected = isConnected;
    notifyListeners();
  }

  String getConnectionState() {
    if (_connected) {
      return 'Connected';
    } else {
      return 'Disconnected';
    }
  }

  bool bluetoothEnabled() {
    _statusListener ??= _flutterReactiveBle.statusStream.listen((status) {
      switch (status) {
        case BleStatus.poweredOff:
          print('[bluetoothEnabled] BLE powered off');
          _bluetoothIsEnabled = false;
          disableBluetooth();
          break;
        case BleStatus.unauthorized:
          print('[bluetoothEnabled] BLE unauthorized');
          _bluetoothIsEnabled = false;
          disableBluetooth();
          break;
        case BleStatus.unknown:
          print('[bluetoothEnabled] BLE unknown');
          _bluetoothIsEnabled = false;
          break;
        case BleStatus.unsupported:
          print('[bluetoothEnabled] BLE unsupported');
          _bluetoothIsEnabled = false;
          disableBluetooth();
          break;
        case BleStatus.ready:
          print('[bluetoothEnabled] BLE ready');
          _bluetoothIsEnabled = true;
          startScan();
          break;
        case BleStatus.locationServicesDisabled:
          print('[bluetoothEnabled] BLE location services disabled');
          _bluetoothIsEnabled = true;
          startScan();
          break;
        default:
          _bluetoothIsEnabled = false;
          disableBluetooth();
          break;
      }
    });
    return _bluetoothIsEnabled;
  }

  void disableBluetooth() {
    stopScan();
    _device = null;
    setConnectionState(false);
    _connectionListener?.cancel();
    _connectionListener = null;
    _timeCharacteristicListener?.cancel();
    _timeCharacteristicListener = null;
    _topicCharacteristicListener?.cancel();
    _topicCharacteristicListener = null;
  }

  void stopScan() {
    _scanListener?.cancel();
    _scanListener = null;
  }

  bool connectToDevice(DiscoveredDevice device) {
    print('[connectToDevice] connecting...');
    _connectionListener ??= _flutterReactiveBle
        .connectToDevice(
      id: device.id,
      servicesWithCharacteristicsToDiscover: {
        Uuid.parse(_bleUuidServiceTime): [],
        Uuid.parse(_bleUuidServiceTopic): []
      },
      connectionTimeout: const Duration(seconds: 2),
    )
        .listen((connectionState) async {
      connectionState.connectionState;
      switch (connectionState.connectionState) {
        case DeviceConnectionState.disconnecting:
        case DeviceConnectionState.disconnected:
          print('[connectToDevice] disconnecting/disconnected');
          setConnectionState(false);
          disableBluetooth();
          startScan();
          break;
        case DeviceConnectionState.connected:
          print('[connectToDevice] connected');
          _device = device;
          if (_connected == false) {
            await _flutterReactiveBle.requestMtu(
                deviceId: _device!.id, mtu: 247);
          }
          setConnectionState(true);
          stopScan();
          subscribeToCharacteristic(device);
          break;
        case DeviceConnectionState.connecting:
          setConnectionState(false);
          print('[connectToDevice] connecting');
          break;
      }
    }, onError: (Object error) {
      String sError = error.toString();
      print('[connectToDevice] error: $sError');
    });
    return true;
  }

  void subscribeToCharacteristic(DiscoveredDevice device) async {
    print('[subscribeToCharacteristic] subscribing...');
    List<Service> sList =
        await _flutterReactiveBle.getDiscoveredServices(device.id);

    _timeCharacteristic = QualifiedCharacteristic(
        serviceId: sList[2].id,
        characteristicId: Uuid.parse(_bleUuidCharacteristicTime),
        deviceId: device.id);
    _flutterReactiveBle.subscribeToCharacteristic(_timeCharacteristic!).listen(
        (data) {
      handleMessage(String.fromCharCodes(data));
    }, onError: (dynamic error) {
      // code to handle errors
    });

    await _flutterReactiveBle.readCharacteristic(_timeCharacteristic!);

    _topicCharacteristic = QualifiedCharacteristic(
        serviceId: sList[3].id,
        characteristicId: Uuid.parse(_bleUuidCharacteristicTopic),
        deviceId: device.id);
    _flutterReactiveBle.subscribeToCharacteristic(_topicCharacteristic!).listen(
        (data) {
      handleMessage(String.fromCharCodes(data));
    }, onError: (dynamic error) {
      // code to handle errors
    });

    await _flutterReactiveBle.readCharacteristic(_topicCharacteristic!);
  }

  bool startScan() {
    if (_bluetoothIsEnabled) {
      print('[startScan] Bluetooth enabled, starting scan...');
      _scanListener ??= _flutterReactiveBle.scanForDevices(withServices: [
        Uuid.parse(_bleUuidServiceTime),
        Uuid.parse(_bleUuidServiceTopic)
      ], scanMode: ScanMode.balanced).listen((device) {
        // if (device.name == 'TopicWatch-2') {
        connectToDevice(device);
        // }
      }, onError: (Object error) {
        String sError = error.toString();
        print('[startScan] error: $sError');
      });
      return true;
    }
    return false;
  }

//setTime (send time to watch)
  static Future<void> sendTime() async {
    SetTimeMessage messageJSON = SetTimeMessage(
        date: Date(
            year: DateTime.now().year,
            month: DateTime.now().month,
            day: DateTime.now().day),
        time: Time(
            hour: DateTime.now().hour,
            minute: DateTime.now().minute,
            second: DateTime.now().second));
    await writeMessage(messageJSON.toJson().toString(), _timeCharacteristic);
  }

  ///Sends and writes the topic on the specifiek param: index
  ///leave index -1 to prevent overwriting
  static Future<bool> sendTopic(int index, List<TopicModel> topicList) async {
    AddTopicMessage message =
        AddTopicMessage.basedOnIndex(index: index, topicList: topicList);

    await writeMessage(message.toJson().toString(), _topicCharacteristic);
    return true;
  }

  ///Response to 'gettopics' command and sends all topics
  ///Returns TRUE if succesfull OR FALSE if failed
  static Future<bool> sendAllTopics(List<TopicModel> topicList) async {
    if (topicList.isEmpty) {
      //List is empty, nothing to send
      return false;
    }

    AddTopicMessage message = AddTopicMessage.all(topicList: topicList);
    while (message.secondMessage != null) {
      await writeMessage(message.toJson().toString(), _topicCharacteristic!);
      message = message.secondMessage!;
    }
    await writeMessage(message.toJson().toString(), _topicCharacteristic);
    return true;
  }

  static Future<bool> sendRemoveTopic({int index = -1}) async {
    if (index < 0) {
      return false;
    }
    RemoveTopicMessage message = RemoveTopicMessage(index: index);

    await writeMessage(message.toJson().toString(), _topicCharacteristic);
    return true;
  }

  static Future<bool> sendRemoveAllTopics() async {
    RemoveAllTopicsMessage message = RemoveAllTopicsMessage();

    await writeMessage(message.toJson().toString(), _topicCharacteristic);
    return true;
  }

  static Future<bool> writeMessage(
      String message, QualifiedCharacteristic? characteristic) async {
    if (characteristic == null) {
      return false;
    }

    if (_connected) {
      print('Writing...');
      print(message);
      // KNOWN BUG, WHEN THE DEVICE IS DISCONNECTED DURING THIS THE APP CRASHES
      await _flutterReactiveBle.writeCharacteristicWithResponse(characteristic,
          value: message.codeUnits);
      return true;
    }
    return false;
  }

  void handleMessage(String message) async {
    if (message.isEmpty || message.length < 8) {
      //Null check
      return;
    }
    Map<String, dynamic> messageJSON = jsonDecode(message);

    print(messageJSON.toString());

    if (messageJSON.isEmpty) {
      //empty message with no command received, ignore the message
      return;
    }

    if (messageJSON.containsKey('command')) {
      if (messageJSON['command'] == 'getTime') {
        print('[BLE] Received: getTime command');
        await sendTime();
      } else if (messageJSON['command'] == 'getTopics') {
        print('[BLE] Received: getTopics command');
        await sendRemoveAllTopics();
        await sendAllTopics(TopicProvider.getTopics());
      } else if (messageJSON['command'] == 'setTrackedTime') {
        print('setTrackedTimes command found');
        TrackedTimesProvider().addTrackedTime(TopicData.fromJson(messageJSON));
      } else {
        print('Unhandled message');
      }
    }
  }
}
