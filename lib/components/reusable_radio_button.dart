import 'package:flutter/material.dart';
class ReusableRadioButton extends StatefulWidget {
  
  final String? rButtonValue;
  final String? rButtonSelectedValue;
  final Function(String?)? rButtonChoosen;
  final String? rButtonName;
  const ReusableRadioButton({required this.rButtonValue, required this.rButtonSelectedValue, required this.rButtonChoosen, required this.rButtonName});

  @override
  State<ReusableRadioButton> createState() => _ReusableRadioButtonState();
}

class _ReusableRadioButtonState extends State<ReusableRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(value: widget.rButtonValue!, 
        groupValue: widget.rButtonSelectedValue,
         onChanged: widget.rButtonChoosen, 
         activeColor: Colors.pink,),
         Text(widget.rButtonName!,
         style:  const TextStyle(
                        fontFamily: 'Bricolage-M',
                        fontSize: 15.63,
                        color: Colors.black,
                      )),
      ],
    );
  }
}