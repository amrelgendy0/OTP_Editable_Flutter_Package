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
  // final ValueChanged<String> onChanged;
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
      // this.onChanged,
      this.onCompleted})
      : assert(length > 1);

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  List<FocusNode> _focusNodes;
  List<TextEditingController> _textControllers;
  List<Widget> _textFields;
  bool _naFirst;
  @override
  void initState() {
    _naFirst = true;
    super.initState();
    _focusNodes = List<FocusNode>(widget.length);
    _textControllers = List<TextEditingController>(widget.length);
    _textFields = List.generate(widget.length, (int i) {
      return buildTextField(context, i);
    });
  }

  @override
  void didChangeDependencies() {
    if (_naFirst) {
      _textControllers.forEach((element) {
        element.text = '\t';
      });
      _naFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textControllers
        .forEach((TextEditingController controller) => controller.dispose());
    _focusNodes.forEach((element) {
      element.dispose();
    });
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
      if (!includenum(element.text)) {
        oo = false;
      }
    });
    return oo;
  }
  bool n4ta8al = false;
  Widget buildTextField(BuildContext context, int i) {
    bool _isFirst = true;
    if (_focusNodes[i] == null) _focusNodes[i] = new FocusNode();
    if (_textControllers[i] == null)
      _textControllers[i] = new TextEditingController();
    String char = " ";
    return StatefulBuilder(
      builder:
          (BuildContext context, void Function(void Function()) setSsstate) {
        _focusNodes[i].addListener(() {
          Fun(i);
          if (widget.obscureText) {
            setSsstate(() {
              if (includenum(_textControllers[i].text)) {
                char = '•';
              } else
                char = " ";
            });
          }
        });
        return Container(
          width: widget.fieldWidth,
          child: TextField(
            controller: _textControllers[i]
              ..addListener(() {
                _textControllers[i].selection = TextSelection.fromPosition(
                    TextPosition(offset: _textControllers[i].text.length));
                try {
                  _textControllers[i].text = _textControllers[i].text[1];
                } catch (e) {}
                if (_textControllers[i].text == '') {
                  _textControllers[i].text = '\t';
                }
              }),
            keyboardType: widget.keyboardType,
            textAlign: TextAlign.center,
            dragStartBehavior: DragStartBehavior.down,
            showCursor: true,
            maxLines: 1,
            obscuringCharacter: char,
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
              if (!includenum(str)) {
                if (n4ta8al) {
                  _textControllers[i - 1].text = '\t';
                }

                _focusNodes[i].unfocus();
                _focusNodes[i - 1].requestFocus();
              }

              if (includenum(str)) {
                if (_isFirst) {
                  _focusNodes[i].unfocus();
                  _isFirst = false;
                } else {
                  _focusNodes[i].unfocus();
                }
              }
              if (i + 1 != widget.length && str.isNotEmpty) {
                FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
              }
              String currentPin = '';
              _textControllers.forEach((TextEditingController value) {
                currentPin += value.text;
              });
              if (includenum(_textControllers.last.text) && check) {
                widget.onCompleted(currentPin);
              }
              // widget.onChanged(currentPin);
            },
          ),
        );
      },
    );
  }

  bool includenum(String str) {
    if (str.contains('0') ||
        str.contains('1') ||
        str.contains('2') ||
        str.contains('3') ||
        str.contains('4') ||
        str.contains('5') ||
        str.contains('6') ||
        str.contains('7') ||
        str.contains('8') ||
        str.contains('9')) {
      return true;
    } else
      return false;
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

  Fun(int i) {
    if (i != 0) {
      n4ta8al = _textControllers[i].text == '\t' &&
          includenum(_textControllers[i - 1].text);
    } else {
      n4ta8al = false;
    }
  }
}
