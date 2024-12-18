import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sabai_app/screens/contribute_page.dart';
import 'package:sabai_app/screens/homepage.dart';
import 'package:sabai_app/screens/profile.dart';
import 'package:sabai_app/screens/save_jobs.dart';

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
  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widgetList = [
      Homepage(
        showBottomSheet: widget.showButtonSheet,
      ),
      const ContributePage(),
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
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: const Color(0xffF7F7F7),
          selectedItemColor: const Color(0xffFF3997),
          type: BottomNavigationBarType.fixed,
          onTap: onTabChange,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.work_outline_outlined),
              label: 'Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.add_circled),
              label: 'contribute',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: 'Me',
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
