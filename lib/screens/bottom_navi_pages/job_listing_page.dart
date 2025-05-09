import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/bottom_sheet.dart';
//import 'package:sabai_app/components/work_card.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/advanced_filter_page.dart';
import 'package:sabai_app/screens/homepage_menupages/all.dart';
import 'package:sabai_app/screens/homepage_menupages/bestmatches.dart';
//import 'package:sabai_app/screens/homepage_menupages/partnerships.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';
import 'package:sabai_app/screens/notification.dart';
import 'package:sabai_app/services/general_provider.dart';
import 'package:sabai_app/services/job_provider.dart';
import 'package:sabai_app/services/jobfilter_provider.dart';
// import 'package:sabai_app/services/language_provider.dart';
// import 'package:shimmer/shimmer.dart';

class JobListingPage extends StatefulWidget {
  final bool showBottomSheet;
  const JobListingPage({
    super.key,
    this.showBottomSheet = false,
  });

  @override
  State<JobListingPage> createState() => _JobListingPageState();
}

class _JobListingPageState extends State<JobListingPage>
    with TickerProviderStateMixin {
  //final PageController _motivationalTextController = PageController();
  // Timer? _timer;
  // int _currentText = 0;
  // bool _forward = true; // Flag to track direction
  // final List<Map<String, String>> _motivationalSlides = [
  //   {
  //     'image': 'images/motivation1.png',
  //     'text':
  //         '"Hard work pays off. Keep striving, and the right job will come.”'
  //   },
  //   {
  //     'image': 'images/motivation2.png',
  //     'text': '“Stay dedicated; the right job is on its way.”',
  //   },
  //   {
  //     'image': 'images/motivation3.png',
  //     'text': '"Every job is a step forward. Keep going!"'
  //   }
  // ];
  // void _autoScrollText() {
  //   _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
  //     if (_forward) {
  //       if (_currentText < 2) {
  //         _currentText++;
  //       } else {
  //         _forward = false;
  //         _currentText--; // Start moving back
  //       }
  //     } else {
  //       if (_currentText > 0) {
  //         _currentText--;
  //       } else {
  //         _forward = true;
  //         _currentText++; // Start moving forward
  //       }
  //     }

  //     _motivationalTextController.animateToPage(
  //       _currentText,
  //       duration: const Duration(milliseconds: 500),
  //       curve: Curves.easeInOut,
  //     );
  //   });
  // }

  // final List<Widget> _pages = [
  //   const All(),
  //   const BestMatches(),
  //   const Partnerships(),
  // ];

  //int _selectedIndex = 0;

  // List<String> getNavItems(LanguageProvider languageProvider) {
  //   return languageProvider.lan == 'English'
  //       ? ['All', 'Best Matches', 'Sabai Job Partners']
  //       : ['အားလုံး', 'သင်အတွက်', 'Sabai Job မိတ်ဖက်များ'];
  // }

  // late AnimationController _animationController;
  // late Animation<Offset> _offsetAnimation;

  // late List<AnimationController> _menuItemAnimations;
  // late List<Animation<double>> _menuItemScaleAnimations;

  Future<void> loadNotification() async {
    final generalProvider =
        Provider.of<GeneralProvider>(context, listen: false);
    await generalProvider.loadNotification();
  }

  bool isSearching = false;
  bool isSwitch = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadNotification();
      final jobProvider = Provider.of<JobProvider>(context, listen: false);
      jobProvider.setLocatiobType('local');
      final filterProvider =
          Provider.of<JobFilterProvider>(context, listen: false);
      filterProvider.setLocationType('local');
    });

    super.initState();
    // _autoScrollText();
    // Show the bottom sheet automatically after the screen loads
    if (widget.showBottomSheet) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const Bottomsheet(),
          ).whenComplete(() {
            if (!mounted) return;
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const NavigationHomepage(
                  showButtonSheet: false,
                ),
              ),
            );
          });
        },
      );
    }

    // _animationController = AnimationController(
    //   duration: const Duration(milliseconds: 300),
    //   vsync: this,
    // );

    // _offsetAnimation = Tween<Offset>(
    //   begin: const Offset(1.0, 0.0),
    //   end: Offset.zero,
    // ).animate(CurvedAnimation(
    //   parent: _animationController,
    //   curve: Curves.easeOut,
    // ));

    // _menuItemAnimations = List.generate(
    //   _pages.length,
    //   (index) => AnimationController(
    //     duration: const Duration(milliseconds: 150),
    //     vsync: this,
    //   ),
    // );

    // _menuItemScaleAnimations = _menuItemAnimations.map((controller) {
    //   return Tween<double>(begin: 1.0, end: 0.95).animate(
    //     CurvedAnimation(
    //       parent: controller,
    //       curve: Curves.easeInOut,
    //     ),
    //   );
    // }).toList();

    // _animationController.forward();
  }

  @override
  void dispose() {
    // _animationController.dispose();
    // for (var controller in _menuItemAnimations) {
    //   controller.dispose();
    // }
    //_motivationalTextController.dispose();
    //_timer?.cancel();
    super.dispose();
  }

  // void _navigateToPage(int index) {
  //   if (_selectedIndex != index) {
  //     // Reset animation
  //     _animationController.reset();

  //     setState(() {
  //       _selectedIndex = index;
  //     });

  //     // Start forward animation
  //     _animationController.forward();
  //   }
  // }

  //for new appbar
  final List<String> menuItemsList = [
    'Jobs for you ✨',
    'Local Jobs 🇹🇭',
    'Global Jobs ✈️'
  ];
  String selectedValue = 'Jobs for you ✨';

  @override
  Widget build(BuildContext context) {
    var jobProvider = Provider.of<JobProvider>(context);
    var filterProvider = Provider.of<JobFilterProvider>(context);
    var generalProvider = Provider.of<GeneralProvider>(context);
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: const Color(0xffF7F7F7),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: backgroundColor,
          centerTitle: false,
          title: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              style: const TextStyle(
                fontFamily: 'Bricolage-R',
                fontSize: 15,
                color: Colors.black,
              ),
              value: selectedValue,
              isExpanded: true,
              hint: const Text('none'),
              items: menuItemsList
                  .map(
                    (String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                  if (selectedValue == 'Local Jobs 🇹🇭' ||
                      selectedValue == 'Jobs for you ✨' 
                      //selectedValue == 'Best Matched Jobs ✨'
                      ) {
                    jobProvider.setLocatiobType('local');
                    jobProvider.getJobs(true);
                    //jobProvider.getBestMatchedJobs(true);
                    jobProvider.getPartnerJobs(true);
                    jobProvider.fetchPremiumJobs(true);
                    filterProvider.setLocationType('local');
                    filterProvider.getFilterJobs(true);
                  } else if (selectedValue == 'Global Jobs ✈️') {
                    jobProvider.setLocatiobType('global');
                    jobProvider.getJobs(true);
                    //jobProvider.getBestMatchedJobs(true);
                    jobProvider.getPartnerJobs(true);
                    jobProvider.fetchPremiumJobs(true);
                    filterProvider.setLocationType('global');
                    filterProvider.getFilterJobs(true);
                  }
                });
              },
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 30,
                  color: primaryPinkColor,
                ),
              ),
              buttonStyleData: const ButtonStyleData(
                  padding:  EdgeInsets.only(left: 8),
                  width: 150,
                  // decoration: BoxDecoration(
                  //   color: const Color(0xffFFEBF6),
                  //   border: Border.all(color: primaryPinkColor),
                  //   borderRadius: BorderRadius.circular(10),
                  // )
                  ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Badge(
                  textColor: primaryPinkColor,
                  backgroundColor: const Color(0xFFFED7EA),
                  label: Text(generalProvider.notiCount.toString()),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationPage(),
                          ));
                    },
                    child: const Icon(
                      CupertinoIcons.bell,
                      size: 24,
                      color: primaryPinkColor,
                    ),
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const AdvancedFilterPage(),
                //       ),
                //     );
                //   },
                //   icon: const Icon(
                //     Icons.search,
                //     color: primaryPinkColor,
                //     size: 24,
                //   ),
                // ),
                const SizedBox(
                  width: 10,
                ),
                Badge(
                    textColor: primaryPinkColor,
                    backgroundColor: const Color(0xFFFED7EA),
                    label:
                        Text(filterProvider.calculateFilterCount().toString()),
                    child: GestureDetector(
                      onTap: jobProvider.isGuest == false
                          ? () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AdvancedFilterPage(),
                                ),
                              );
                              filterProvider.clearAllFilters();
                              filterProvider.clearFilters();
                              if (result != null) {
                                filterProvider.updateFilterValues(result);
                              }
                            }
                          : null,
                      child: const Icon(
                        CupertinoIcons.search,
                        size: 24,
                        color: primaryPinkColor,
                      ),
                    )),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        ),
        body: const Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 12,
          ),
          child: 
          // selectedValue == 'Best Matched Jobs ✨'
          //     ? const BestMatches()
          //     : 
               All(),
          // Center(
          //     child: const SizedBox(
          //       child: Text('No Data Available'),
          //     ),
          //   ),
        ),
      ),
    );
  }
}


// body: Padding(
//           padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
//           child: Column(
//             children: [
//               // SizedBox for Space
//               const SizedBox(
//                 height: 10,
//               ),
//               // Row Contains Search Bar and Advanced Filter Button
//               if (jobProvider.isGuest == false)
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         width: 295,
//                         height: 40,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(8)),
//                         child: TextField(
//                           controller: _searchController,
//                           decoration: InputDecoration(
//                             hintText: languageProvider.lan == 'English'
//                                 ? 'Search for job'
//                                 : 'အလုပ်များရှာမယ်',
//                             hintStyle: languageProvider.lan == 'English'
//                                 ? GoogleFonts.dmSans(
//                                     textStyle: const TextStyle(
//                                       color: Color(0xff989EA4),
//                                       fontSize: 14,
//                                     ),
//                                   )
//                                 : const TextStyle(
//                                     fontFamily: 'Walone-R',
//                                     color: Color(0xff989EA4),
//                                     fontSize: 14,
//                                   ),
//                             prefixIcon: IconButton(
//                               icon: Icon(
//                                 // searchQuery.isEmpty &&
//                                 isSearching ? Icons.clear : Icons.search,
//                                 color: const Color(0xffFF3997),
//                               ),
//                               onPressed: () {
//                                 if (isSearching) {
//                                   FocusScope.of(context).unfocus();
//                                   // Clear the search query and reset search state
//                                   _searchController.clear();
//                                   setState(() {
//                                     searchQuery = ""; // Clear search query
//                                     isSearching =
//                                         false; // Switch back to search icon
//                                   });
//                                 }
//                               },
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: const BorderSide(
//                                 color: Color(0xffF0F1F2),
//                                 width: 2,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: const BorderSide(
//                                 color: Color(
//                                     0xffFF3997), // Border color when not focused
//                                 width: 1,
//                               ),
//                             ),
//                             contentPadding:
//                                 const EdgeInsets.symmetric(vertical: 17),
//                           ),
//                           onTap: () {
//                             setState(() {
//                               isSearching = true; // Activate search mode
//                             });
//                           },
//                           onChanged: (val) {
//                             setState(() {
//                               searchQuery = val; // Update the search query
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     Badge(
//                       textColor: primaryPinkColor,
//                       backgroundColor: const Color(0xFFFED7EA),
//                       label: Text(
//                           filterProvider.calculateFilterCount().toString()),
//                       child: IconButton(
//                         color: const Color(0xffFF3997),
//                         onPressed: jobProvider.isGuest == false
//                             ? () async {
//                                 final result = await Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         const AdvancedFilterPage(),
//                                   ),
//                                 );
//                                 filterProvider.clearAllFilters();
//                                 filterProvider.clearFilters();
//                                 if (result != null) {
//                                   filterProvider.updateFilterValues(result);
//                                 }
//                               }
//                             : null,
//                         icon: const Icon(
//                           CupertinoIcons.slider_horizontal_3,
//                         ),
//                         style: IconButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             side: const BorderSide(
//                               color: Color(0xffF0F1F2),
//                               width: 2,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               const SizedBox(
//                 height: 15,
//               ),
// else ...[
//               //   Container(
//               //     height: 33,
//               //     decoration: BoxDecoration(
//               //       color: const Color(0xFFF0F1F2),
//               //       borderRadius: BorderRadius.circular(8),
//               //     ),
//               //     child: TabBar(
//               //       tabAlignment: TabAlignment.center,
//               //       automaticIndicatorColorAdjustment: true,
//               //       isScrollable: true,
//               //       padding:
//               //           const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
//               //       indicatorSize: TabBarIndicatorSize.tab,
//               //       indicator: BoxDecoration(
//               //         color: Colors.white,
//               //         borderRadius: BorderRadius.circular(8),
//               //       ),
//               //       labelColor: Colors.pink,
//               //       unselectedLabelColor: Colors.pink.shade300,
//               //       dividerColor: Colors.transparent,
//               //       labelStyle: const TextStyle(
//               //           fontSize: 12.5,
//               //           color: Color(0xffFF3997),
//               //           fontFamily: 'Bricolage-R'),
//               //       tabs: [
//               //         const Tab(text: "All"),
//               //         Tab(
//               //           child: Shimmer.fromColors(
//               //             baseColor: const Color(0xffFF3997),
//               //             highlightColor: Colors.white,
//               //             child: const Text(
//               //               "Best Matches",
//               //             ),
//               //           ),
//               //         ),
//               //         const Tab(text: "Sabai Job Partner"),
//               //       ],
//               //     ),
//               //   ),
//               //   const SizedBox(
//               //     height: 15,
//               //   ),
//               //   const Expanded(
//               //     child: TabBarView(
//               //         children: [All(), BestMatches(), Partnerships()]),
//               //   ),
//               // ]

// //old app bar
// // appBar: AppBar(
// //           title: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Row(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   Transform.scale(
// //                     scale: 0.7,
// //                     child: CupertinoSwitch(
// //                       activeTrackColor: primaryPinkColor,
// //                       value: isSwitch,
// //                       onChanged: (value) async {
// //                         setState(() {
// //                           isSwitch = value;
// //                           if (isSwitch == true) {
// //                             jobProvider.setLocatiobType('global');
// //                             filterProvider.setLocationType('global');
// //                           } else {
// //                             jobProvider.setLocatiobType('local');
// //                             filterProvider.setLocationType('local');
// //                           }
// //                         });
// //                         await jobProvider.getJobs(true);
// //                         await jobProvider.getBestMatchedJobs(true);
// //                         await jobProvider.getPartnerJobs(true);
// //                         await jobProvider.fetchPremiumJobs(true);
// //                         await filterProvider.getFilterJobs(true);
// //                       },
// //                     ),
// //                   ),
// //                   Text(
// //                     isSwitch == false ? 'Local Jobs' : 'Global Jobs',
// //                     style: const TextStyle(
// //                         fontFamily: 'Bricolage-M', fontSize: 10),
// //                   ),
// //                 ],
// //               ),
// //               const Spacer(),
// //               // Center title
// //               languageProvider.lan == 'English'
// //                   ? const Text(
// //                       "Jobs",
// //                       style: TextStyle(
// //                         fontFamily: 'Bricolage-M',
// //                         fontSize: 19.53,
// //                       ),
// //                     )
// //                   : const Text(
// //                       "အလုပ်များ",
// //                       style: TextStyle(
// //                         fontFamily: 'Walone-B',
// //                         fontSize: 19.53,
// //                       ),
// //                     ),
// //               const Spacer(
// //                 flex: 2,
// //               ),
// //             ],
// //           ),
// //           centerTitle: false,
// //           actions: [
// //             IconButton(
// //               onPressed: () {
// //                 Navigator.pushReplacement(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => const NotificationPage(),
// //                   ),
// //                 );
// //               },
// //               icon: const Icon(
// //                 CupertinoIcons.bell,
// //                 color: Color(0xffFF3997),
// //               ),
// //             ),
// //           ],
// //           bottom: PreferredSize(
// //             preferredSize:
// //                 const Size.fromHeight(1.0), // Height of the bottom border
// //             child: Container(
// //               color: Colors.grey.shade300, // Border color
// //               height: 1.0, // Border thickness
// //             ),
// //           ),
// //           backgroundColor: const Color(0xffF0F1F2),
// //           surfaceTintColor: Colors.transparent,
// //           shadowColor: Colors.transparent,
// //           automaticallyImplyLeading: false,
// //         ),

//               // // Motivational Quotes
//               // SizedBox(
//               //   height: 35,
//               //   child: PageView.builder(
//               //     physics: const NeverScrollableScrollPhysics(),
//               //     scrollDirection: Axis.vertical,
//               //     controller: _motivationalTextController,
//               //     itemCount: _motivationalSlides.length,
//               //     itemBuilder: (context, index) {
//               //       return Row(
//               //         children: [
//               //           Image.asset(
//               //             _motivationalSlides[index]['image']!,
//               //             width: 28,
//               //             height: 28,
//               //           ),
//               //           const SizedBox(
//               //             width: 10,
//               //           ),
//               //           Expanded(
//               //               child: Text(
//               //             _motivationalSlides[index]['text']!,
//               //             style: const TextStyle(
//               //               fontFamily: 'Bricolage-M',
//               //               fontSize: 12,
//               //             ),
//               //           ))
//               //         ],
//               //       );
//               //     },
//               //   ),
//               // ),

//               // original code
//               // if (isSearching) ...[
//               //   Expanded(
//               //     child: ListView.builder(
//               //         itemCount: filterJobs.length,
//               //         itemBuilder: (context, index) {
//               //           var job = filterJobs[index];
//               //           var jobInfo = job['info'] as Map<String, dynamic>;
//               //           return WorkCard(
//               //             jobTitle: jobInfo['title'],
//               //             isPartner: jobInfo['is_partner'],
//               //             companyName: jobInfo['company_name'],
//               //             location: jobInfo['location'],
//               //             maxSalary: jobInfo['salary_max'],
//               //             minSalary: jobInfo['salary_min'],
//               //             currency: jobInfo['currency'],
//               //             jobId: jobInfo['id'],
//               //             closingAt: jobInfo['closing_at'],
//               //             safetyLevel: jobInfo['safety_level'],
//               //             viewCount: jobInfo['views_count'],
//               //           );
//               //         }),
//               //   ),
//               // ]
//               // else ...[
//               //   Container(
//               //     decoration: BoxDecoration(
//               //       color: const Color(0xffF0F1F2),
//               //       borderRadius: BorderRadius.circular(8),
//               //     ),
//               //     height: 50,
//               //     child: Row(
//               //       mainAxisAlignment: MainAxisAlignment.spaceAround,
//               //       children: List.generate(
//               //         getNavItems(languageProvider).length,
//               //         (index) => GestureDetector(
//               //           onTapDown: (_) {
//               //             // Animate scale down when tapped
//               //             _menuItemAnimations[index].forward();
//               //           },
//               //           onTapUp: (_) {
//               //             // Animate scale back and navigate
//               //             _menuItemAnimations[index].reverse();
//               //             _navigateToPage(index);
//               //           },
//               //           onTapCancel: () {
//               //             // Animate scale back if tap is cancelled
//               //             _menuItemAnimations[index].reverse();
//               //           },
//               //           child: ScaleTransition(
//               //             scale: _menuItemScaleAnimations[index],
//               //             child: Container(
//               //               padding: const EdgeInsets.symmetric(
//               //                   horizontal: 10, vertical: 8),
//               //               decoration: BoxDecoration(
//               //                 color: _selectedIndex == index
//               //                     ? Colors.white
//               //                     : Colors.transparent,
//               //                 borderRadius: BorderRadius.circular(8),
//               //               ),
//               //               child: Text(
//               //                 getNavItems(languageProvider)[index],
//               //                 style: const TextStyle(
//               //                   color: Color(0xffFF3997),
//               //                   fontFamily: 'Bricolage-R',
//               //                   fontSize: 12.5,
//               //                 ),
//               //               ),
//               //             ),
//               //           ),
//               //         ),
//               //       ),
//               //     ),
//               //   ),
//               //   const SizedBox(
//               //     height: 15,
//               //   ),
//               //   Expanded(
//               //     child: SlideTransition(
//               //       position: _offsetAnimation,
//               //       child: _pages[_selectedIndex],
//               //     ),
//               //   ),
//               // ],
//             ],
//           ),
//         ),