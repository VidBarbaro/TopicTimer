import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/bluetooth_info_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/topbar.dart';

class MobileSettingsPage extends StatelessWidget {
  const MobileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(
          key: super.key,
        ),
        const Text(
            'This page is being used for BLE testing with the embedded device, please do not change the content of this page'),
        ElevatedButton(
            onPressed: () => context.read<BluetoothInfoProvider>().scan(),
            child: const Text('Scan'))
      ],
    );
  }
}
