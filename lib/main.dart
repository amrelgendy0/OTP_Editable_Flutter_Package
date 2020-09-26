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
  String Otp = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          OTPTextField(
            length: 5,
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
            width: 460,
       onCompleted: (String){
              print(String);
       },
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 40,
          ),
          if (Otp.trim() != '')
            FlatButton(
              onPressed: () {
                print(Otp);
              },
              child: Text(
                "$Otp",
                style: TextStyle(fontSize: 20),
              ),
            ),
        ],
      ),
    );
  }
}
