import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/ble_messages.dart';

class BluetoothInfoProvider with ChangeNotifier {
  DiscoveredDevice? _device;

  static const String _baseUUID = '0000-1000-8000-00805f9b34fb';
  final String _bleUuidServiceTime = '961db84e-$_baseUUID';
  final String _bleUuidServiceTopic = '961dbf38-$_baseUUID';

  final String _bleUuidCharacteristicTime = '961dc0dc-$_baseUUID';
  final String _bleUuidCharacteristicTopic = '961dc24e-$_baseUUID';

  final _flutterReactiveBle = FlutterReactiveBle();

  bool _bluetoothIsEnabled = false;
  bool _connected = false;

  StreamSubscription<DiscoveredDevice>? _scanListener;
  StreamSubscription<BleStatus>? _statusListener;
  StreamSubscription<ConnectionStateUpdate>? _connectionListener;

  StreamSubscription<List<int>>? _timeCharacteristicListener;
  StreamSubscription<List<int>>? _topicCharacteristicListener;
  QualifiedCharacteristic? _timeCharacteristic;
  QualifiedCharacteristic? _topicCharacteristic;

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
    _connected = false;
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
    print(device.serviceUuids.toString());
    _connectionListener ??= _flutterReactiveBle
        .connectToDevice(
      id: device.id,
      servicesWithCharacteristicsToDiscover: {
        Uuid.parse(_bleUuidServiceTime): [],
        Uuid.parse(_bleUuidServiceTopic): []
      },
      connectionTimeout: const Duration(seconds: 2),
    )
        .listen((connectionState) {
      connectionState.connectionState;
      switch (connectionState.connectionState) {
        case DeviceConnectionState.disconnecting:
        case DeviceConnectionState.disconnected:
          print('[connectToDevice] disconnecting/disconnected');
          _connected = false;
          disableBluetooth();
          startScan();
          break;
        case DeviceConnectionState.connected:
          print('[connectToDevice] connected');
          _device = device;
          _connected = true;
          stopScan();
          subscribeToCharacteristic(device);
          break;
        case DeviceConnectionState.connecting:
          _connected = false;
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

    List<int> timeCharacteristicValue =
        await _flutterReactiveBle.readCharacteristic(_timeCharacteristic!);
    handleMessage(String.fromCharCodes(timeCharacteristicValue));

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

    List<int> topicCharacteristicValue =
        await _flutterReactiveBle.readCharacteristic(_topicCharacteristic!);
    handleMessage(String.fromCharCodes(topicCharacteristicValue));
  }

  bool startScan() {
    if (_bluetoothIsEnabled) {
      print('[startScan] Bluetooth enabled, starting scan...');
      _scanListener ??= _flutterReactiveBle.scanForDevices(withServices: [
        Uuid.parse(_bleUuidServiceTime),
        Uuid.parse(_bleUuidServiceTopic)
      ], scanMode: ScanMode.balanced).listen((device) {
        print('[startScan] Found device with given services');
        connectToDevice(device);
      }, onError: (Object error) {
        String sError = error.toString();
        print('[startScan] error: $sError');
      });
      return true;
    }
    return false;
  }

//setTime (send time to watch)
  Future<void> sendTime() async {
    SetTimeMessage messageJSON = SetTimeMessage(
        date: Date(
            years: DateTime.now().year,
            months: DateTime.now().month,
            days: DateTime.now().day),
        time: Time(
            hours: DateTime.now().hour,
            minutes: DateTime.now().minute,
            seconds: DateTime.now().second));
    await writeMessage(messageJSON.toJson().toString(), _timeCharacteristic!);
  }

  ///Response to 'gettopics' command
  ///Returns TRUE if succesfull OR FALSE if failed
  Future<bool> sendTopics() async {
    if (TopicProvider.topiclist.isEmpty) {
      return false;
    }
    for (int i = 0; i < TopicProvider.topiclist.length; i++) {
      SetTopics messageJSON = SetTopics(topic: TopicProvider.topiclist[i]);
      print(messageJSON.toJson().toString());
      await writeMessage(
          messageJSON.toJson().toString(), _topicCharacteristic!);
    }
    return true;
  }

  Future<bool> writeMessage(
      String message, QualifiedCharacteristic characteristic) async {
    if (_connected) {
      print('Writing...');
      print(message);
      await _flutterReactiveBle.writeCharacteristicWithResponse(characteristic,
          value: message.codeUnits);
      return false;
    }
    return true;
  }

  void handleMessage(String message) async {
    if (message.isEmpty || message.length < 8) {
      //Null check
      return;
    }
    Map<String, dynamic> messageJSON = jsonDecode(message);

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
        await sendTopics();
      } else {
        print('Unhandled message');
      }
    }
  }
}
