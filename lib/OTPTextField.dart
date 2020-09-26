import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPTextField extends StatefulWidget {
  final int length;
  final double width;
  final double fieldWidth;
  TextInputType keyboardType;
  final TextStyle style;
  final MainAxisAlignment textFieldAlignment;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onCompleted;
  OTPTextField(
      {Key key,
      this.length = 2,
      this.width = 6,
      this.fieldWidth = 60,
      this.keyboardType = TextInputType.number,
      this.style = const TextStyle(),
      this.textFieldAlignment = MainAxisAlignment.spaceBetween,
      this.obscureText = false,
      this.onChanged,
      this.onCompleted})
      : assert(length > 1);

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}
class _OTPTextFieldState extends State<OTPTextField> {
  List<FocusNode> _focusNodes;
  List<TextEditingController> _textControllers;
List<bool> _isfirstList;
  List<Widget> _textFields;

  @override
  void initState() {
    super.initState();
    _isfirstList=List<bool>.filled(widget.length,true);
    _focusNodes = List<FocusNode>(widget.length);
    _textControllers = List<TextEditingController>(widget.length);
    _textFields = List.generate(widget.length, (int i) {
      return buildTextField(context, i);
    });
  }

  @override
  void dispose() {
    _textControllers
        .forEach((TextEditingController controller) => controller.dispose());
    _focusNodes.forEach((element) {element.dispose(); });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Row(
        mainAxisAlignment: widget.textFieldAlignment,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _textFields,
      ),
    );
  }

  bool get check {
    bool oo = true;
    _textControllers.forEach((element) {
      if (element.text.trim() == '') {
        oo = false;
      }
    });
    return oo;
  }

  Widget buildTextField(BuildContext context, int i) {
    bool _isFirst = true;
    if (_focusNodes[i] == null) _focusNodes[i] = new FocusNode();
    if (_textControllers[i] == null)
      _textControllers[i] = new TextEditingController();
    return Container(
      width: widget.fieldWidth,
      child: TextField(
        controller: _textControllers[i]..addListener(() {
          _textControllers[i].selection = TextSelection.fromPosition(
              TextPosition(offset: _textControllers[i].text.length));
          try {
            _textControllers[i].text = _textControllers[i].text[1];
          }catch(e){}

        }),
        keyboardType: widget.keyboardType,
        textAlign: TextAlign.center,
        dragStartBehavior: DragStartBehavior.down,
        showCursor: true,
        style: widget.style,
        focusNode: _focusNodes[i],
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        onChanged: (String str) {
          if (str.isEmpty) {
            print('na hna1');
            _focusNodes[i].unfocus();
            _focusNodes[i - 1].requestFocus();
          }
          if (str.isNotEmpty) {
            print('na hna2');

            if (_isFirst) {
              print('na hna3');

              _focusNodes[i].unfocus();
              _isFirst = false;
            } else {
              print('na hna4');
              // _textControllers[i].text = str[1];
              // print(str);
              _focusNodes[i].unfocus();
            }
          }
          if (i + 1 != widget.length && str.isNotEmpty) {
            print('na hna5');
            FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
          }



          String currentPin='';
          _textControllers.forEach((TextEditingController value) {
            currentPin += value.text;
          });
          if (_textControllers.last.text.trim()!=''&&check) {
            widget.onCompleted(currentPin);
          }
          widget.onChanged(currentPin);

        },
      ),
    );
  }

  // String swap(List<String> tries) {
  //   List last = List.generate(tries.last.length, (index) => tries.last[index]);
  //   List beforelast = List.generate(tries[tries.length - 2].length,
  //       (index) => tries[tries.length - 2][index]);
  //
  //   last.forEach((element1) {
  //     beforelast.forEach((element2) {
  //       if (element1 != element2) {
  //         return element1;
  //       }
  //     });
  //   });

  // beforelast.forEach((element) {
  //   last.remove(element);
  // });
  // print("$tries and we remove ${last[0]}");

}
