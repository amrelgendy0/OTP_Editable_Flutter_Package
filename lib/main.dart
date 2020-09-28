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
            length: 6,
            obscureText: false,
            style: TextStyle(fontSize: 70),
            fieldWidth: 40,
            textFieldAlignment: MainAxisAlignment.spaceEvenly,
            width: 480,
            smsResevierStreamReady: Future.delayed(Duration(seconds: 2)).then((value) => "234578").asStream(),
            onCompleted: (String) {
              setState(() {
                print(String);
              });
            },
          ),
          SizedBox(
            height: 40,
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {

            },
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
