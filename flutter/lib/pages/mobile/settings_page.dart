import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topictimer_flutter_application/components/mobile/providers/bluetooth_info_provider.dart';
import 'package:topictimer_flutter_application/components/mobile/theme_change.dart';
import 'package:topictimer_flutter_application/components/mobile/topbar.dart';

class MobileSettingsPage extends StatelessWidget {
  const MobileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BluetoothInfoProvider>().bluetoothEnabled();
    return Column(
      children: [
        TopBar(
          key: super.key,
        ),
        // THEME CHANGER
        const ThemeChangeComponent()
      ],
    );
  }
}
