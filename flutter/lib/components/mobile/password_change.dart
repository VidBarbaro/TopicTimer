import 'package:flutter/material.dart';

class PasswordChangeComp extends StatelessWidget {
  PasswordChangeComp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(106, 106, 106, 0.2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        constraints: const BoxConstraints(maxWidth: 270, maxHeight: 235),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment(-0.85, -0.75),
              child: Text(
                'Password',
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            _buildPasswordField('Old password'),
            _buildPasswordField('New password'),
            _buildPasswordField('Confirm new password'),
            Align(
              alignment: Alignment(0.75, 0.85),
              child: ElevatedButton(
                onPressed: () {
                  // Action to perform when the button is pressed
                  print('Button pressed!');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 193, 7, 1),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(String hintText) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: SizedBox(
        height: 35,
        width: 230,
        child: TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromRGBO(255, 255, 255, 1),
            border: OutlineInputBorder(),
            hintText: hintText,
            contentPadding: const EdgeInsets.all(1),
          ),
        ),
      ),
    );
  }
}
