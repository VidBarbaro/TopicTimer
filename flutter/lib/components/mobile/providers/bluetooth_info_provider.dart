import 'package:flutter/foundation.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BluetoothInfoProvider with ChangeNotifier {
  final flutterReactiveBle = FlutterReactiveBle();

  void scan() {
    print(flutterReactiveBle.scanRegistry.discoveredDevices.length);

    flutterReactiveBle
        .scanForDevices(withServices: [], scanMode: ScanMode.lowLatency);
  }
}
