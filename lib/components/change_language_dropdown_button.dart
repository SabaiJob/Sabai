import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/services/language_provider.dart';

class DropDown extends StatefulWidget {
  const DropDown({super.key});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? selectedValue = "English";
  Function(String)? whenChanged;
  final List<Map<String, String>> items = [
    {"name": "English", "icon": "icons/uk.png"},
    {"name": "မြန်မာ", "icon": "icons/myanmar.png"}
  ];

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        iconStyleData: const IconStyleData(
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
                        style: GoogleFonts.bricolageGrotesque(
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (String? value) {
          setState(() {
            selectedValue = value;
            languageProvider.setLan(value!);
          });
        },
        buttonStyleData: ButtonStyleData(
            elevation: 10,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 30,
            width: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            )),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}
