import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/services/quote_provider.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentText = 0;

  void _autoScrollText() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        final quoteProvider =
            Provider.of<QuoteProvider>(context, listen: false);
        if (quoteProvider.quotes.isNotEmpty) {
          setState(() {
            _currentText = (_currentText + 1) % quoteProvider.quotes.length;
          });
          _pageController.animateToPage(
            _currentText,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _autoScrollText();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var quoteProvider = Provider.of<QuoteProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F7F7),
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
                "Community",
                style: appBarTitleStyleEng,
              )
            : const Text(
                'Community',
                style: appBarTitleStyleMn,
              ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xFFFF3997),
        ),
      ),
      body: DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: 35,
                child: PageView.builder(
                  scrollDirection: Axis.vertical,
                  controller: _pageController,
                  itemCount: quoteProvider.quotes.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Image.asset(
                          'images/motivation1.png',
                          width: 28,
                          height: 28,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          "${quoteProvider.quotes[index]['text']}",
                          style: const TextStyle(
                            fontFamily: 'Bricolage-M',
                            fontSize: 12,
                          ),
                        ))
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 33,
                decoration: BoxDecoration(
                  color:
                      const Color(0xFFF0F1F2), // Background color for tab bar
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TabBar(
                  tabAlignment: TabAlignment.start,
                  automaticIndicatorColorAdjustment: true,
                  isScrollable: true,
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelColor: Colors.pink,
                  unselectedLabelColor: Colors.pink.shade300,
                  dividerColor: Colors.transparent,
                  labelStyle: const TextStyle(
                      fontSize: 12.5,
                      color: Color(0xffFF3997),
                      fontFamily: 'Bricolage-R'),
                  tabs: const [
                    Tab(text: 'Labor Rights'),
                    Tab(text: 'Workers\' advocacy'),
                    Tab(text: 'Fair Work Foundation'),
                    Tab(text: 'Employment Support'),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: TabBarView(children: [
                Center(
                  child: Text('Labor Rights'),
                ),
                Center(
                  child: Text('Workers\' Advocacy'),
                ),
                Center(
                  child: Text('Fair Work Foundation'),
                ),
                Center(
                  child: Text('Employment Support'),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
