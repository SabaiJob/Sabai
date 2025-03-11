import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_content_holder.dart';
import 'package:sabai_app/components/reusable_title_holder.dart';
import 'package:sabai_app/constants.dart';
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
          // SizedBox(
          //   height: 400,
          //   child: ListView.separated(
          //     separatorBuilder: (context, index) => const SizedBox(
          //       height: 10,
          //     ),
          //     itemCount: jobCategoryLength!,
          //     itemBuilder: (context, index) {
          //       return Card(
          //         color: Colors.white,
          //         child: CheckboxListTile(
          //           checkboxScaleFactor: 0.75,
          //           title: Row(
          //             mainAxisSize: MainAxisSize.max,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   jobCategoryList![index]['name'],
          //                   style: const TextStyle(
          //                     fontFamily: 'Bricolage-R',
          //                     fontSize: 15.62,
          //                   ),
          //                 ),
          //                 const SizedBox(
          //                   width: 5,
          //                 ),
          //                 SizedBox(
          //                 width: 20,
          //                 height: 20,
          //                 child: ClipRRect(
          //                   borderRadius: BorderRadius.circular(8),
          //                   child: Image.network(
          //                     jobCategoryList![index]['image'],

          //                     fit: BoxFit.cover,
          //                     loadingBuilder: (context, child, loadingProgress) {
          //                       if (loadingProgress == null) return child;
          //                       return const Center(
          //                         child: CircularProgressIndicator(strokeWidth: 2),
          //                       );
          //                     },
          //                     errorBuilder: (context, error, stackTrace) =>
          //                         const Icon(Icons.error, size: 64, color: Colors.red),
          //                   ),
          //                 ),
          //               ),
          //               ]),
          //           activeColor: Colors.pink,
          //           value: jobCategoryList![index]['selected'],
          //           onChanged: (value) {
          //             whenOnChanged(value, index);
          //           },
          //         ),
          //       );
          //     },
          //   ),
          // ),
          Wrap(
            //spacing: ,
            spacing: 25,
            runSpacing: 10.0,
            children: List.generate(
              jobCategoryLength!,
              (index) => _buildJobCategoryChip(
                context,
                jobCategoryList![index],
                index,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildJobCategoryChip(
      BuildContext context, Map jobCategory, int index) {
    bool isSelected = jobCategory['selected'] ?? false;

    return ChoiceChip(
      avatar: SizedBox(
        width: 24,
        height: 24,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            jobCategory['image'],
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              );
            },
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error, size: 16, color: Colors.red),
          ),
        ),
      ),
      label: Text(
        jobCategory['name'],
        style: TextStyle(
          fontFamily: 'Bricolage-R',
          fontSize: 14,
          color: isSelected ? Color(0xFF4C5258) : Color(0xFF989EA4) ,
        ),
      ),
      selected: isSelected,
      selectedColor: Colors.transparent,
      color: const WidgetStatePropertyAll(Colors.white),
      backgroundColor: Colors.white,
      side: BorderSide(
        color: isSelected ? primaryPinkColor : Color(0xFFF0F1F2)
      ),
      showCheckmark: false,
      elevation: 1,
      padding: EdgeInsets.symmetric(horizontal: 4),
      onSelected: (bool selected) {
        whenOnChanged(selected, index);
      },
    );
  }
}
