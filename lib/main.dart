import 'package:flutter/material.dart';
import 'package:otp/OTPTextField.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  String Otp='';
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 100,),
            OTPTextField(
              length: 5,style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),
              width: 460,
              onCompleted: (s) {
                setState(() {
                  Otp=s;

                });
              },
              keyboardType: TextInputType.number,
            ),SizedBox(height: 40,),Text(Otp,style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    );
  }
}
