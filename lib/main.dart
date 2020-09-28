import 'package:flutter/material.dart';
import 'package:otp/OTPTextField.dart';

void main() {
  runApp(Ma());
}

class Ma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OTP(),
    );
  }
}

class OTP extends StatefulWidget {
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          OTPTextField(
            onCompleted: (a) {
              print('$a');
            },
          ),
          SizedBox(
            height: 40,
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {},
            child: Text(
              "dd",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
