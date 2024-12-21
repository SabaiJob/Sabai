import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/bottom_sheet.dart';
import 'package:sabai_app/screens/advanced_filter_page.dart';
import 'package:sabai_app/screens/homepage_menupages/all.dart';
import 'package:sabai_app/screens/homepage_menupages/bestmatches.dart';
import 'package:sabai_app/screens/homepage_menupages/partnerships.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';
import 'package:sabai_app/services/language_provider.dart';

class JobListingPage extends StatefulWidget {
  final bool showBottomSheet;
  const JobListingPage({super.key, this.showBottomSheet = false});

  @override
  State<JobListingPage> createState() => _JobListingPageState();
}

class _JobListingPageState extends State<JobListingPage>
    with TickerProviderStateMixin {
  final List<Widget> _pages = [
    const All(),
    const BestMatches(),
    const Partnerships(),
  ];

  int _selectedIndex = 0;

  List<String> getNavItems(LanguageProvider languageProvider) {
    return languageProvider.lan == 'English'
        ? ['All', 'Best Matches', 'Sabai Job Partners']
        : ['အားလုံး', 'သင်အတွက်', 'Sabai Job မိတ်ဖက်များ'];
  }

  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  late List<AnimationController> _menuItemAnimations;
  late List<Animation<double>> _menuItemScaleAnimations;

  @override
  void initState() {
    super.initState();
    // Show the bottom sheet automatically after the screen loads
    if (widget.showBottomSheet) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const Bottomsheet(),
          ).whenComplete(() {
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

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _menuItemAnimations = List.generate(
      _pages.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 150),
        vsync: this,
      ),
    );

    _menuItemScaleAnimations = _menuItemAnimations.map((controller) {
      return Tween<double>(begin: 1.0, end: 0.95).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    for (var controller in _menuItemAnimations) {
      controller.dispose();
    }
    super.dispose();
  }

  void _navigateToPage(int index) {
    if (_selectedIndex != index) {
      // Reset animation
      _animationController.reset();

      setState(() {
        _selectedIndex = index;
      });

      // Start forward animation
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        title: languageProvider.lan == 'English'
            ? const Text(
                "Jobs",
                style: TextStyle(
                  fontFamily: 'Bricolage-M',
                  fontSize: 19.53,
                ),
              )
            : const Text(
                "အလုပ်များ",
                style: TextStyle(
                  fontFamily: 'Walone-B',
                  fontSize: 19.53,
                ),
              ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.bell,
              color: Color(0xffFF3997),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(1.0), // Height of the bottom border
          child: Container(
            color: Colors.grey, // Border color
            height: 1.0, // Border thickness
          ),
        ),
        backgroundColor: const Color(0xffF0F1F2),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'images/motivation.png',
                  width: 28,
                  height: 28,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Text(
                    '"Hard work pays off. Keep striving, and the right job will come."',
                    style: TextStyle(
                      fontFamily: 'Bricolage-M',
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    //width: 295,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: SearchAnchor(
                      builder:
                          (BuildContext context, SearchController controller) {
                        return SearchBar(
                          backgroundColor: const WidgetStatePropertyAll<Color>(
                            Colors.white,
                          ),
                          controller: controller,
                          padding: const WidgetStatePropertyAll<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 16.0)),
                          onTap: () {
                            controller.openView();
                          },
                          onChanged: (_) {
                            controller.openView();
                          },
                          leading: const Icon(
                            Icons.search,
                            color: Colors.pink,
                          ),
                        );
                      },
                      suggestionsBuilder:
                          (BuildContext context, SearchController controller) {
                        return List<ListTile>.generate(5, (int index) {
                          final String item = 'item $index';
                          return ListTile(
                            title: Text(item),
                            onTap: () {
                              setState(() {
                                controller.closeView(item);
                              });
                            },
                          );
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                  color: const Color(0xffFF3997),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdvancedFilterPage()));
                  },
                  icon: const Icon(
                    CupertinoIcons.slider_horizontal_3,
                  ),
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffF0F1F2),
                borderRadius: BorderRadius.circular(8),
              ),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  getNavItems(languageProvider).length,
                  (index) => GestureDetector(
                    onTapDown: (_) {
                      // Animate scale down when tapped
                      _menuItemAnimations[index].forward();
                    },
                    onTapUp: (_) {
                      // Animate scale back and navigate
                      _menuItemAnimations[index].reverse();
                      _navigateToPage(index);
                    },
                    onTapCancel: () {
                      // Animate scale back if tap is cancelled
                      _menuItemAnimations[index].reverse();
                    },
                    child: ScaleTransition(
                      scale: _menuItemScaleAnimations[index],
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 21, vertical: 8),
                        decoration: BoxDecoration(
                          color: _selectedIndex == index
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          getNavItems(languageProvider)[index],
                          style: const TextStyle(
                            color: Color(0xffFF3997),
                            fontFamily: 'Bricolage-R',
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: SlideTransition(
                position: _offsetAnimation,
                child: _pages[_selectedIndex],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
