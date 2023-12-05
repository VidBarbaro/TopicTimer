import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:topictimer_flutter_application/bll/topic_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/models/ble_messages.dart';

class BluetoothInfoProvider with ChangeNotifier {
  //These variables aren't used outside the class, but could be handy later on for updating the UI
  BluetoothDevice? _device; //Bluetoothdevice which is the TopicTimer
  BluetoothCharacteristic? _characteristic; //Characterestic to write to
  StreamSubscription<List<ScanResult>>?
      _scannerListener; //scannerListener is triggered when a new message is received
  StreamSubscription<BluetoothConnectionState>?
      _connectionListener; //connectionListener is triggered when the connection gets updated
  StreamSubscription<List<int>>? _messageListener; //
  bool _connected = false;
  String getConnectionState() {
    if (_connected) {
      return 'Connected';
    } else {
      return 'Disconnected';
    }
  }

  void enableBluetooth() async {
    if (!await FlutterBluePlus.isSupported) {
      print('[ERROR] Bluetooth not supported by this device');
      return;
    }

    if (await Permission.bluetoothScan.request().isGranted) {
      if (await Permission.bluetoothConnect.request().isGranted) {
        FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
          print(state);
          if (state == BluetoothAdapterState.on) {
            //Do your action
            print('[SUCCESS] initialised bluetooth adapter');
            startScan();
          } else {
            print('[ERROR] Bleutooth adapter could not be started');
            return;
          }
        });
      }
      if (Platform.isAndroid) {
        await FlutterBluePlus.turnOn();
      }
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
    } catch (ex) {
      print(ex.toString());
    }
    if (device.isConnected) {
      //set up connectionListener
      _connectionListener = device.connectionState.listen((event) {
        if (event == BluetoothConnectionState.disconnected) {
          _connected = false;
          notifyListeners();
          connectToDevice(device);
        } else if (event == BluetoothConnectionState.connected) {
          _connected = true;
          notifyListeners();
        }
      });
      List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.uuid.toString() ==
              'a6846b78-7efa-11ee-b962-0242ac120002') {
            _characteristic = characteristic;
            _characteristic?.setNotifyValue(true);
            _messageListener =
                _characteristic?.lastValueStream.listen((event) async {
              if (_characteristic!.properties.notify) {
                try {
                  List<int> value = await _characteristic!.read();
                  String message = String.fromCharCodes(value);
                  handleMessage(
                      message); //Somehow the message can't be printed to the monitor
                } catch (ex) {
                  _messageListener?.cancel();
                }
              }
            });
          }
        }
      }
    }
  }

  void disconnectDevice() {
    if (_scannerListener != null) {
      _scannerListener?.cancel();
    }
    // if (_connectionListener != null) {
    //   _connectionListener?.cancel();
    // }
    if (_messageListener != null) {
      _messageListener?.cancel();
    }
  }

  void startScan() async {
    print('Start scanning');
    await FlutterBluePlus.startScan();
    _scannerListener = FlutterBluePlus.scanResults.listen((results) {
      if (results.isNotEmpty) {
        ScanResult r = results.last; // the most recently found device
        //print(
        // '${r.device.remoteId}: "${r.advertisementData.localName}" found!');
        if (r.advertisementData.localName == 'TopicWatch') {
          stopScan();
          _device = r.device;
          connectToDevice(r.device);
        }
      }
    });
  }

  void stopScan() async {
    FlutterBluePlus.stopScan();
  }

  //setTime (send time to watch)
  void sendTime() {
    SetTimeMessage messageJSON = SetTimeMessage(
        date: Date(
            years: DateTime.now().year,
            months: DateTime.now().month,
            days: DateTime.now().day),
        time: Time(
            hours: DateTime.now().hour,
            minutes: DateTime.now().minute,
            seconds: DateTime.now().second));
    writeMessage(messageJSON.toJson().toString());
  }

  ///Response to 'gettopics' command
  ///Returns TRUE if succesfull OR FALSE if failed
  bool sendTopics() {
    if (TopicProvider.topiclist.isEmpty) {
      return false;
    }
    for (int i = 0; i < TopicProvider.topiclist.length; i++) {
      SetTopics messageJSON = SetTopics(topic: TopicProvider.topiclist[i]);
      print(messageJSON.toJson().toString());
      writeMessage(messageJSON.toJson().toString());
    }
    return true;
  }

  Future<void> writeMessage(String message) async {
    String messageString = jsonEncode(message);
    if (!_device!.isConnected) {
      return;
    }
    if (_characteristic == null) {
      return;
    }
    print('[BLE] Sending: ');
    print(messageString);
    //messageString = messageString.substring(1, messageString.length - 1);
    List<int> numbers = messageString.codeUnits.toList();

    await _characteristic?.write(numbers);

    // while (_characteristic?.lastValue != 'Free') {
    //   await _characteristic?.write(numbers);
    // }
  }

  Future<void> freeCharacteristic() async {
    await _characteristic?.write('Free' as List<int>);
  }

  void handleMessage(String message) {
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
        sendTime();
      } else if (messageJSON['command'] == 'getTopics') {
        print('[BLE] Received: getTopics command');
        sendTopics();
      } else {
        print('Unhandled message');
      }
    }
    freeCharacteristic();
  }
}
