import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';

class BluetoothInfoProvider with ChangeNotifier {
  BluetoothDevice? _device;
  BluetoothCharacteristic? _characteristic;

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
            print('Succesfully initialised bluetooth adapter');
          } else {
            print('[ERROR] Bleutooth adapter could not be started');
            print(state);
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
    await device.discoverServices();
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() ==
            'a6846b78-7efa-11ee-b962-0242ac120002') {
          _characteristic = characteristic;
          characteristic.setNotifyValue(true);
          characteristic.lastValueStream.listen((value) {
            print("Received data: ${String.fromCharCodes(value)}");
            handleMessage(String.fromCharCodes(value));
          });
        }
      }
    }
  }

  void startScan() async {
    print('Start scanning');
    await FlutterBluePlus.startScan();
    var subscription = FlutterBluePlus.scanResults.listen((results) {
      if (results.isNotEmpty) {
        ScanResult r = results.last; // the most recently found device
        print(
            '${r.device.remoteId}: "${r.advertisementData.localName}" found!');
        if (r.advertisementData.localName == "TopicWatch") {
          stopScan();
          _device = r.device;
          connectToDevice(r.device);
        }
      }
    });
  }

  void stopScan() async {
    print('stopped scanning');
    FlutterBluePlus.stopScan();
  }

  void handleMessage(String message) {
    print(message);
    if (message.isEmpty) {
      return;
    }
    message = message.substring(0, message.length - 1);
    print('handle message');
    if (_characteristic == null) {
      print('characteristic is null');
      return;
    }
    if (message == 'Time?') {
      print('sending');
      print(TimeOfDay.now().toString());
      _characteristic?.write(
          '${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}'
              .codeUnits);
    }
  }
}
