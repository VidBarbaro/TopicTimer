import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';

class BluetoothInfoProvider with ChangeNotifier {
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

      // Setup Listener for scan results.
      var subscription = FlutterBluePlus.scanResults.listen(
        (results) async {
          if (results.isNotEmpty) {
            ScanResult r = results.last; // the most recently found device
            print(
                '${r.device.remoteId}: "${r.advertisementData.localName}" found!');
            if (r.advertisementData.localName == 'TopicWatch') {
              FlutterBluePlus.stopScan();
              await r.device.connect(autoConnect: true);

              print("succesfully connected to TopicWatch");
              List<BluetoothService> services =
                  await r.device.discoverServices();
              services.forEach((service) {
                print('service found: ');
                print(service.serviceUuid.toString());
                if (service.serviceUuid.toString() ==
                    'a6846862-7efa-11ee-b962-0242ac120002') {
                  service.characteristics.forEach((element) {
                    if (element.characteristicUuid.toString() ==
                        'a6846b78-7efa-11ee-b962-0242ac120002') {
                      print('writing data');
                      element.write([0x21, 0x22, 0x23, 0x24]);
                    }
                  });
                } else {
                  print('Niet dood');
                }
              });
              stopScan();
            } else {
              print('something went wrong connecting');
            }
          }
        },
      );
      // if (FlutterBluePlus.connectedDevices.isEmpty) {
      //   print('subscription canceled');
      //   subscription.cancel();
      // }
    }
  }

  void startScan() async {
    print('Start scanning');
    FlutterBluePlus.startScan();
  }

  void stopScan() async {
    print('stopped scanning');
    FlutterBluePlus.stopScan();
  }
}
