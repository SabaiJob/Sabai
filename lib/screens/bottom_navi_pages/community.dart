import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
  //motivational quote animation
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
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  List categoires = [];
  List communities = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final quoteProvider = Provider.of<QuoteProvider>(context, listen: false);
      if (!quoteProvider.isLoading) {
        _autoScrollText();
      }
    });
    fetchCategoires();
  }

  Future<void> fetchCategoires() async {
    final response = await http.get(Uri.parse(
        'https://sabai-job-backend-k9wda.ondigitalocean.app/api/community/categories/'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      setState(() {
        categoires = jsonDecode(response.body);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
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
        length: categoires.length,
        initialIndex: 0,
        child: categoires.isEmpty ?
        const Center(child: CircularProgressIndicator(
          color: primaryPinkColor,
        ),) : Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                height: 35,
                child: Consumer<QuoteProvider>(
                  builder: (context, quoteProvider, child) {
                    if (quoteProvider.isLoading) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: primaryPinkColor,
                      ));
                    }
                    if (quoteProvider.quotes.isEmpty) {
                      return const Center(
                        child: Text("No quotes available."),
                      );
                    }
                    return PageView.builder(
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
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "${quoteProvider.quotes[index]['text']}",
                                style: const TextStyle(
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 33,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F1F2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TabBar(
                        tabAlignment: TabAlignment.start,
                        automaticIndicatorColorAdjustment: true,
                        isScrollable: true,
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 3),
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
                          fontFamily: 'Bricolage-R',
                        ),
                        tabs: categoires
                            .map((category) => Tab(text: category['name']))
                            .toList(),
                      ),
              ),
            ),
            const Expanded(
              child: TabBarView(children: [
                Center(child: Text('Labor Rights')),
                Center(child: Text('Workers\' Advocacy')),
                Center(child: Text('Fair Work Foundation')),
                Center(child: Text('Employment Support')),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
