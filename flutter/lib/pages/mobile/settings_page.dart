import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/bluetooth_info_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/theme_change_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/theme_change.dart';
import 'package:topictimer_flutter_application/components/mobile/topbar.dart';

class MobileSettingsPage extends StatelessWidget {
  const MobileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BluetoothInfoProvider>().enableBluetooth();
    return Column(
      children: [
        TopBar(
          key: super.key,
        ),
        const Text(
            'This page is being used for BLE testing with the embedded device, please do not change the content of this page'),
        ElevatedButton(
            onPressed: () => context.read<BluetoothInfoProvider>().startScan(),
            child: const Text('Start scanning')),
        ElevatedButton(
            onPressed: () => context.read<BluetoothInfoProvider>().stopScan(),
            child: const Text('Stop scanning')),
        ElevatedButton(
            onPressed: () => context.read<BluetoothInfoProvider>().sendTime(),
            child: const Text('Send Time message to the watch')),

        
        // THEME CHANGER
        const ThemeChangeComponent()
      ],
    );
  }
}
