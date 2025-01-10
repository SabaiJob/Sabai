import 'package:flutter/material.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/communities_pages/fair_work_foundation.dart';
import 'package:sabai_app/screens/communities_pages/labor_rights.dart';
import 'package:sabai_app/screens/communities_pages/workers_advocacy.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> with TickerProviderStateMixin {
  final List<Widget> _pages = [
    LaborRight(),
    const WorkersAdvocacy(),
    const FairWorkFoundation(),
  ];

  int _selectedIndex = 0;

  List<String> getNavItems() {
    return [
      'Labor Rights',
      'Workers\' Advocacy',
      'Fair Work Foundation',
    ];
  }

  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  late List<AnimationController> _menuItemAnimations;
  late List<Animation<double>> _menuItemScaleAnimations;

  @override
  void initState() {
    super.initState();

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
    _animationController.dispose();
    for (var controller in _menuItemAnimations) {
      controller.dispose();
    }
    super.dispose();
  }

  void _navigateToPage(int index) {
    if (_selectedIndex != index) {
      _animationController.reset();

      setState(() {
        _selectedIndex = index;
      });

      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Community',
          style: appBarTitleStyleEng,
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey.shade300,
            height: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Image.asset(
                  'images/status.png',
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 5),
                const Text(
                  'We\'ve Got Your Back!',
                  style: TextStyle(
                    fontFamily: 'Bricolage-M',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  getNavItems().length,
                  (index) => GestureDetector(
                    onTapDown: (_) {
                      _menuItemAnimations[index].forward();
                    },
                    onTapUp: (_) {
                      _menuItemAnimations[index].reverse();
                      _navigateToPage(index);
                    },
                    onTapCancel: () {
                      _menuItemAnimations[index].reverse();
                    },
                    child: ScaleTransition(
                      scale: _menuItemScaleAnimations[index],
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: _selectedIndex == index
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          getNavItems()[index],
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
          ),
          Expanded(
            child: SlideTransition(
              position: _offsetAnimation,
              child: _pages[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
