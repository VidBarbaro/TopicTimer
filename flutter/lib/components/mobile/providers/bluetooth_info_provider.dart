import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

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
    await device.connect();
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
    _messageListener?.cancel();
    _connectionListener?.cancel();
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

  void handleMessage(String message) {
    if (message.isEmpty) {
      return;
    }
    message = message.substring(0, message.length - 1);
    if (_characteristic == null) {
      return;
    }
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
