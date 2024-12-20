import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/services/language_provider.dart';

class ReusableTextformfield extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String? Function(String?)? validating;
  final String? hint;
  const ReusableTextformfield(
      {super.key,
      required this.textEditingController,
      required this.validating,
      required this.hint});
  //const ReusableTextformfield({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvier = Provider.of<LanguageProvider>(context);
    return SizedBox(
      width: 400,
      height: 56,
      child: TextFormField(
          controller: textEditingController,
          validator: validating,
          style: languageProvier.lan == 'English'
              ? const TextStyle(
                  fontFamily: 'Bricolage-R',
                  fontSize: 14,
                )
              : const TextStyle(
                  fontFamily: 'Walone-R',
                  fontSize: 14,
                ),
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0x00ffffff),
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0x00ffffff),
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(top: 1, bottom: 1, left: 10),
            hintStyle: const TextStyle(
              color: Color(0xFF7B838A),
              fontSize: 14,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            helperText: '',
            errorStyle: const TextStyle(
              fontSize: 10,
              color: Colors.red,
            ),
            errorMaxLines: 1,
          )),
    );
  }
}
