import 'package:flutter/material.dart';
import 'package:topictimer_flutter_application/components/mobile/topbar.dart';
import 'package:topictimer_flutter_application/components/mobile/profile_details.dart';
import 'package:topictimer_flutter_application/components/mobile/school_details.dart';
import 'package:topictimer_flutter_application/components/mobile/password_change.dart';

class MobilePersonalPage extends StatelessWidget {
  const MobilePersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(
          key: super.key,
        ),
        // ProfileDetailsComp
        ProfileDetailsComp(key: super.key),
        // SchoolDetailsComp
      
        // PasswordChangeComp

      ],
    );
  }
}
