import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReusableDatePicker extends StatefulWidget {
  final String? choosenLanguage;
  final Function(DateTime) onDateSelected;

  const ReusableDatePicker(
      {super.key, required this.choosenLanguage, required this.onDateSelected});

  @override
  State<ReusableDatePicker> createState() => _ReusableDatePickerState();
}

class _ReusableDatePickerState extends State<ReusableDatePicker> {


  DateTime? _selectedDate;

  // Future<void> _pickDate(BuildContext context) async {
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: _selectedDate ??
  //         DateTime(2000), // Default or previously selected date
  //     firstDate: DateTime(1950),
  //     lastDate: DateTime.now(),
  //   );
  //   if (pickedDate != null) {
  //     setState(() {
  //       _selectedDate = pickedDate;
  //     });
  //     widget.onDateSelected(pickedDate); // Pass the selected date back
  //   }
  // }
  Future<void> _pickDate(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: _selectedDate ?? DateTime(2000), // Default or previously selected date
    firstDate: DateTime(1950),
    lastDate: DateTime.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: Colors.teal, 
          //accentColor: Colors.teal, // For widgets like buttons
          colorScheme: const ColorScheme.light(primary: Colors.black), 
          buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary), // Button text style
        ),
        child: child!,
      );
    },
  );
  
  if (pickedDate != null) {
    setState(() {
      _selectedDate = pickedDate;
    });
    widget.onDateSelected(pickedDate); // Pass the selected date back
  }
}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 36,
      child: TextButton(
          onPressed: () {
            _pickDate(context);
          },
           style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), // Set the border radius
                          ),
                        ),
          child: Align(
            alignment: Alignment.topLeft,
            child : Text(
              _selectedDate == null ?
              widget.choosenLanguage! : DateFormat('yyyy-MM-dd').format(_selectedDate!).toString(),
              style: widget.choosenLanguage == 'English'
                  ? const TextStyle(
                      fontFamily: 'Bricolage-R',
                      fontSize: 14,
                      color: Color(0xFF7B838A),
                    )
                  : const TextStyle(
                      fontFamily: 'Walone-R',
                      fontSize: 14,
                      color: Color(0xFF7B838A),
                    ),
            )
          )),
    );
  }
}
