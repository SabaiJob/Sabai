import 'package:flutter/material.dart';
import 'package:sabai_app/constants.dart';

class ReusableRadiobuttonListtiles extends StatefulWidget {
  final String title;
  final String value;
  final String selectedOption;
  final Function(String?) onChanged;
  const ReusableRadiobuttonListtiles(
      {super.key,
      required this.title,
      required this.value,
      required this.selectedOption,
      required this.onChanged});

  @override
  State<ReusableRadiobuttonListtiles> createState() =>
      _ReusableRadiobuttonListtilesState();
}

class _ReusableRadiobuttonListtilesState
    extends State<ReusableRadiobuttonListtiles> {
  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
      radioScaleFactor: 0.8,
      title: Text(
        widget.title,
        style: const TextStyle(
            fontSize: 15.63, fontFamily: 'Bricolage-M',),
      ),
      value: widget.value,
      groupValue: widget.selectedOption,
      onChanged: widget.onChanged,
      activeColor: primaryPinkColor,
    );
  }
}
