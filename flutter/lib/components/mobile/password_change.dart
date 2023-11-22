import 'package:flutter/material.dart';

class PasswordChangeComp extends StatelessWidget {
  PasswordChangeComp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(106, 106, 106, 0.2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: SizedBox(
          width: 270,
          height: 210,
          child: Column(
            children: [
              Text('Password'),
              const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(6.0),
                    child: SizedBox(
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(255, 255, 255, 1),
                          border: OutlineInputBorder(),
                          hintText: 'Old password',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(6.0),
                    child: SizedBox(
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(255, 255, 255, 1),
                          border: OutlineInputBorder(),
                          hintText: 'New password',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(6.0),
                    child: SizedBox(
                      height: 35,
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(255, 255, 255, 1),
                          border: OutlineInputBorder(),
                          hintText: 'New password',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Action to perform when the button is pressed
                  print('Button pressed!');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                ),
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
