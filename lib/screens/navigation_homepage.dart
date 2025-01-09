import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/screens/bottom_navi_pages/community.dart';
import 'package:sabai_app/screens/bottom_navi_pages/contribute_page.dart';
import 'package:sabai_app/screens/bottom_navi_pages/job_listing_page.dart';
import 'package:sabai_app/screens/bottom_navi_pages/profile.dart';
import 'package:sabai_app/screens/bottom_navi_pages/save_jobs.dart';
import 'package:sabai_app/services/language_provider.dart';

class NavigationHomepage extends StatefulWidget {
  final bool showButtonSheet;
  const NavigationHomepage({
    super.key,
    this.showButtonSheet = false,
  });

  @override
  State<NavigationHomepage> createState() => _NavigationHomepageState();
}

class _NavigationHomepageState extends State<NavigationHomepage> {
  late List<Widget> widgetList;
  int currentIndex = 2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widgetList = [
      const Community(),
      const ContributePage(),
      JobListingPage(
        showBottomSheet: widget.showButtonSheet,
      ),
      const SaveJobs(),
      const Profile(),
    ];
  }

  void onTabChange(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 90,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: const Color(0xffF7F7F7),
          selectedItemColor: const Color(0xffFF3997),
          selectedLabelStyle: languageProvider.lan == 'English'
              ? const TextStyle(
                  fontFamily: 'Bricolage-R',
                  fontSize: 12.5,
                )
              : const TextStyle(
                  fontFamily: 'Walone-B',
                  fontSize: 11,
                ),
          unselectedLabelStyle: languageProvider.lan == 'English'
              ? const TextStyle(
                  fontFamily: 'Bricolage-R',
                  fontSize: 12,
                )
              : const TextStyle(
                  fontFamily: 'Walone-B',
                  fontSize: 10,
                ),
          type: BottomNavigationBarType.fixed,
          onTap: onTabChange,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.apartment),
              label:
                  languageProvider.lan == 'English' ? 'Community' : 'အလုပ်ရှာ',
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.add_circled),
              label:
                  languageProvider.lan == 'English' ? 'Contribute' : 'အလုပ်တင်',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.work_outline_outlined),
              label: languageProvider.lan == 'English' ? 'Jobs' : 'အလုပ်ရှာ',
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.heart),
              label: languageProvider.lan == 'English'
                  ? 'Saved'
                  : 'သိမ်းထားသည်များ',
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.profile_circled),
              label: languageProvider.lan == 'English' ? 'Me' : 'ပရိုဖိုင်',
            ),
            // _buildItem(Icons.work_outline_outlined, 'Jobs', 0),
            // _buildItem(CupertinoIcons.add_circled, 'Contribute', 1),
            // _buildItem(CupertinoIcons.heart, 'Saved', 2),
            // _buildItem(CupertinoIcons.profile_circled, 'Me', 3),
          ],
        ),
      ),
      body: widgetList[currentIndex],
    );
  }

  // BottomNavigationBarItem _buildItem(IconData icon, String label, int index) {
  //   return BottomNavigationBarItem(
  //     icon: Icon(icon),
  //     label: currentIndex != index ? label : '',
  //     activeIcon: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Icon(icon),
  //         const SizedBox(
  //           height: 1,
  //         ),
  //         Text(
  //           label,
  //           style: const TextStyle(fontSize: 12, color: Color(0xffFF3997)),
  //         ),
  //         if (currentIndex == index)
  //           const Icon(
  //             CupertinoIcons.staroflife_fill,
  //             size: 8,
  //           )
  //       ],
  //     ),
  //   );
  // }
}
