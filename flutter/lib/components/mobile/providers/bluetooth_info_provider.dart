import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:topictimer_flutter_application/components/mobile/models/ble_messages.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/topbar_content_provider.dart';

class BluetoothInfoProvider with ChangeNotifier {
  //These variables aren't used outside the class, but could be handy later on for updating the UI
  BluetoothDevice? _device; //Bluetoothdevice which is the TopicTimer
  BluetoothCharacteristic? _characteristic; //Characterestic to write to
  StreamSubscription<List<ScanResult>>?
      _messageListener; //messageListener is triggered when a new message is received
  StreamSubscription<BluetoothConnectionState>?
      _connectionListener; //connectionListener is triggered when the connection gets updated

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
          connectToDevice(device);
        }
      });
    }
    await device.discoverServices();
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() ==
            'a6846b78-7efa-11ee-b962-0242ac120002') {
          _characteristic = characteristic;
          characteristic.setNotifyValue(true);
          characteristic.lastValueStream.listen((value) {
            print('Received data: ${String.fromCharCodes(value)}');
            handleMessage(String.fromCharCodes(value));
          });
        }
      }
    }
  }

  void disconnectDevice() {
    if (_messageListener != null) {
      _messageListener?.cancel();
    }
    if (_connectionListener != null) {
      _connectionListener?.cancel();
    }
  }

  void startScan() async {
    print('Start scanning');
    await FlutterBluePlus.startScan();
    _messageListener = FlutterBluePlus.scanResults.listen((results) {
      if (results.isNotEmpty) {
        ScanResult r = results.last; // the most recently found device
        print(
            '${r.device.remoteId}: "${r.advertisementData.localName}" found!');
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

  void writeMessage(String message) {
    SetTimeMessage message = SetTimeMessage(
        date: Date(
            years: DateTime.now().year,
            months: DateTime.now().month,
            days: DateTime.now().day),
        time: Time(
            hours: TimeOfDay.now().hour,
            minutes: TimeOfDay.now().minute,
            seconds: 0));

    DateTimeJSON begin = DateTimeJSON.now();
    DateTimeJSON end = DateTimeJSON.now();
    end.setTime(Time(hours: 16, minutes: 30, seconds: 15));
    SetTrackedTimes message2 =
        SetTrackedTimes(data: TopicData(beginTime: begin, endTime: end, id: 1));

    SetTopics message3 =
        SetTopics(topic: Topic(id: 1, name: 'Programming', color: Colors.blue));

    print('SetTimeMessage JSON print');
    String messageString = jsonEncode(message);
    print(messageString);
    if (_characteristic == null) {
      return;
    }
    List<int> numbers = messageString.codeUnits.toList();
    _characteristic?.write(numbers);
  }

  void handleMessage(String message) {
    if (message.isEmpty) {
      //Null check
      return;
    }

    //Clean string by removing zero terminator
    message = message.substring(0, message.length - 1);
    if (_characteristic == null) {
      return;
    }
    //Convert from string to JSON command
    var messageJSON = json.decode(message);

    print('Printing the found command');
    print(messageJSON['command'].toString());

    switch (message) {
      case 'Time?':
        _characteristic?.write(
            '${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}'
                .codeUnits);
        break;
      default:
        //Unhandled message
        break;
    }
  }
}
