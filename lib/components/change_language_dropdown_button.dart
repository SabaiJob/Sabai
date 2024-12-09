import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';

class DropDown extends StatefulWidget {
  const DropDown({super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? selectedValue = "English";
  Function(String)? whenChanged;
  final List<Map<String, String>> items =[
    {"name" : "English", "icon" : "icons/uk.png"},
    {"name" : "MM", "icon" : "icons/myanmar.png"}
  ] ;

  @override
  Widget build(BuildContext context) {
    return Container(
  
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          iconStyleData: IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down),
          ),
          isExpanded: true,
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item["name"],
                    child: Row(
                      children: [
                        Image.asset(
                          item["icon"]!,
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          item["name"]!,
                          style: GoogleFonts.bricolageGrotesque(textStyle:  TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (String? value) {
            setState(() {
              selectedValue = value;
            });
          },
          buttonStyleData: ButtonStyleData(
            elevation: 10,
            padding: EdgeInsets.symmetric(horizontal: 1),
            height: 24,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            )
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      ),
    );
}}
