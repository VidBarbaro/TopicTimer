import 'dart:io';

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
        (results) {
          if (results.isNotEmpty) {
            ScanResult r = results.last; // the most recently found device
            print(
                '${r.device.remoteId}: "${r.advertisementData.localName}" found!');
          }
        },
      );
    }
  }

  void startScan() async {
    FlutterBluePlus.startScan();
  }

  void getScanResults() async {
    FlutterBluePlus.stopScan();
    if (await FlutterBluePlus.scanResults.length > 0) {
      print(FlutterBluePlus.scanResults.last.toString());
    }
  }
}
