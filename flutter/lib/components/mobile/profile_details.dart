import 'package:flutter/material.dart';

class ProfileDetailsComp extends StatelessWidget {
  ProfileDetailsComp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    return Container(
      color: Color.fromRGBO(0, 150, 136, 1),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 75,
                  backgroundColor: Color.fromRGBO(255, 202, 175, 1),
                  child: CircleAvatar(
                    radius: 65,
                    backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                    child: Center(
                      child: Icon(
                        Icons.person, 
                        color: Color.fromRGBO(255, 202, 175, 1),
                        size: 130,
                        ),
                    )
                  ),
                ),
                SizedBox(height: 20),
                // Is the white border around the text as shown in figma needed? No in built property by flutter
                Text(
                  'John Doe',
                  style: TextStyle(
                    color: Color.fromRGBO(3, 169, 244, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}