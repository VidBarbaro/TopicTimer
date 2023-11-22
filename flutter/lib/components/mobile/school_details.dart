import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SchoolDetailsComp extends StatelessWidget {
  SchoolDetailsComp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    return Container(
        width: 100.w,
        height: 12.h,
        color: Colors.blue,
        child: const Center(
              child: Text(
                'School name',
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  ),
              ),
            )
        );
  }

}