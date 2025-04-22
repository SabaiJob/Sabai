import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_label.dart';
import 'package:sabai_app/components/reusable_textformfield.dart';
import 'package:sabai_app/components/reusable_title_holder.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/services/language_provider.dart';

class RedeemRewardsPage extends StatelessWidget {
  const RedeemRewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey.shade300,
              height: 1.0,
            )),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: languageProvider.lan == 'English'
            ? const Text(
                "Redeem Rewards",
                style: appBarTitleStyleEng,
              )
            : const Text(
                'Redeem Rewards',
                style: appBarTitleStyleMn,
              ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xFFFF3997),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: ReusableLabelHolder(
                        labelName: 'Full Name',
                        textStyle: TextStyle(
                            fontFamily: 'Bricolage-M',
                            fontSize: 15.63,
                            color: Colors.black),
                        isStarred: true)),
                TextField(
                    textInputAction: TextInputAction.done,
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
                      hintText: 'Cameron Williamson',
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
                      contentPadding:
                          const EdgeInsets.only(top: 1, bottom: 1, left: 10),
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
                              color: Colors.red,
                              fontSize: 10,
                              fontFamily: 'Bricolage-M')
                          : const TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontFamily: 'Walone-R'),
                      errorMaxLines: 1,
                    )),
                const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: ReusableLabelHolder(
                        labelName: 'Email Address',
                        textStyle: TextStyle(
                            fontFamily: 'Bricolage-M',
                            fontSize: 15.63,
                            color: Colors.black),
                        isStarred: false)),
                TextField(
                    textInputAction: TextInputAction.done,
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
                      hintText: 'Enter your email address',
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
                      contentPadding:
                          const EdgeInsets.only(top: 1, bottom: 1, left: 10),
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
                              color: Colors.red,
                              fontSize: 10,
                              fontFamily: 'Bricolage-M')
                          : const TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontFamily: 'Walone-R'),
                      errorMaxLines: 1,
                    )),
                const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: ReusableLabelHolder(
                        labelName: 'Phone Number',
                        textStyle: TextStyle(
                            fontFamily: 'Bricolage-M',
                            fontSize: 15.63,
                            color: Colors.black),
                        isStarred: true)),
                TextField(
                    textInputAction: TextInputAction.done,
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
                      hintText: '06 1234567',
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
                      contentPadding:
                          const EdgeInsets.only(top: 1, bottom: 1, left: 10),
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
                              color: Colors.red,
                              fontSize: 10,
                              fontFamily: 'Bricolage-M')
                          : const TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontFamily: 'Walone-R'),
                      errorMaxLines: 1,
                    )),
                const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: ReusableLabelHolder(
                        labelName: 'Address',
                        textStyle: TextStyle(
                            fontFamily: 'Bricolage-M',
                            fontSize: 15.63,
                            color: Colors.black),
                        isStarred: false)),
                TextField(
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
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
                      hintText: 'Enter your address',
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
                      contentPadding:
                          const EdgeInsets.only(top: 1, bottom: 1, left: 10),
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
                              color: Colors.red,
                              fontSize: 10,
                              fontFamily: 'Bricolage-M')
                          : const TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontFamily: 'Walone-R'),
                      errorMaxLines: 1,
                    )),
              ],
            ),
          ),
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            fixedSize: const Size(343, 42),
            backgroundColor: const Color(0xffFF3997),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              languageProvider.lan == 'English'
                  ? const Text(
                      'Submit',
                      style: textButtonTextStyleEng,
                    )
                  : const Text(
                      'Submit',
                      style: textButtonTextStyleMm,
                    ),
            ],
          ),
        )
      ],
    );
  }
}
