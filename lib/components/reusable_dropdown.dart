// NOT CURRENTLY USING
// NEED TO REFACTOR
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/services/language_provider.dart';

class ReusableDropdown extends StatelessWidget {
  final List<String> dropdownItems;
  final String? selectedItem;
  final Function(String?) whenOnChanged;
  final String? hintText;
  final double? cusWidth;
  final double? cusHeight;

  const ReusableDropdown(
      {required this.dropdownItems,
      required this.selectedItem,
      required this.whenOnChanged,
      this.hintText,
      required this.cusWidth,
      required this.cusHeight});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.pink,
          ),
        ),
        hint: Text(
          hintText!,
          style: languageProvider == 'English'
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
        ),
        isExpanded: true,
        items: dropdownItems
            .map(
              (String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: languageProvider.lan == 'English'
                      ? const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Bricolage-R',
                          color: Color(0xFF7B838A),
                        )
                      : const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Walone-R',
                          color: Color(0xFF7B838A),
                        ),
                ),
              ),
            )
            .toList(),
        value: selectedItem,
        onChanged: whenOnChanged,
        buttonStyleData: ButtonStyleData(
          elevation: 10,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: cusHeight!,
          width: cusWidth!,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        dropdownStyleData: const DropdownStyleData(
            elevation: 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            )),
      ),
    );
  }
}
