import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/components/reusable_title_holder.dart';
import 'package:sabai_app/services/language_provider.dart';

class SelectJobCategoryPage extends StatelessWidget {
  final int? jobCategoryLength;
  final List? jobCategoryList;
  final Function(bool?, int?) whenOnChanged;
  const SelectJobCategoryPage(
      {super.key,
      required this.jobCategoryLength,
      required this.jobCategoryList,
      required this.whenOnChanged});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          // title
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Align(
              alignment: Alignment.topLeft,
              child: ReusableTitleHolder(
                title: languageProvider.lan == 'English'
                    ? 'Select Your Job Preferences'
                    : 'အလုပ်အကိုင်အမျိုးအစားများ',
              ),
            ),
          ),

          // subtitle
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Align(
              alignment: Alignment.topLeft,
              child: ReusableContentHolder(
                  content: languageProvider.lan == 'English'
                      ? 'Choose the job categories that interest you.This helps us match you with the best opportunities'
                      : 'သင်စိတ်ဝင်စားရာအလုပ်အကိုင်အမျိုးအစားများကို ရွေးချယ်ပါ။သင့်နဲ့ကိုက်ညီမယ့်အကောင်းဆုံး အလုပ်အခွင့်အလမ်းများကို ကျွန်တော်တို့ ပြပေးနိုင်ပါသည်။'),
            ),
          ),

          // Job Categories List
          SizedBox(
            height: 400,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: jobCategoryLength!,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  child: CheckboxListTile(
                    checkboxScaleFactor: 0.75,
                    title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jobCategoryList![index]['name'],
                            style: const TextStyle(
                              fontFamily: 'Bricolage-R',
                              fontSize: 15.62,
                            ),
                          ),
                          Image.network(
                            jobCategoryList![index]['image'],
                            scale: 55,
                          ),
                        ]),
                    activeColor: Colors.pink,
                    value: jobCategoryList![index]['selected'],
                    onChanged: (value) {
                      whenOnChanged(value, index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
