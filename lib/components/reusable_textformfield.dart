import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/services/language_provider.dart';

class ReusableTextformfield extends StatelessWidget {
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final String? Function(String?)? validating;
  final String? hint;
  final List<TextInputFormatter>? formatter;

  const ReusableTextformfield({
    super.key,
    this.keyboardType = TextInputType.text,
    this.formatter,
    required this.textEditingController,
    required this.validating,
    required this.hint,
  });
  //const ReusableTextformfield({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return SizedBox(
      width: 400,
      height: 56,
      child: TextFormField(
          textInputAction: TextInputAction.done,
          inputFormatters: formatter,
          keyboardType: keyboardType,
          controller: textEditingController,
          validator: validating,
          onEditingComplete: (){
            FocusScope.of(context).unfocus();
          },
          style: languageProvider.lan == 'English'
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
            errorStyle: languageProvider.lan == 'English'
                ? const TextStyle(
                    color: Colors.red, fontSize: 10, fontFamily: 'Bricolage-M')
                : const TextStyle(
                    color: Colors.red, fontSize: 10, fontFamily: 'Walone-R'),
            errorMaxLines: 1,
          )),
    );
  }
}
