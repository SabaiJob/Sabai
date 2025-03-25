import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/community_detail.dart';
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
  Map<int, List> communityData = {}; // Store community data for each category
  Map<int, int> currentPage = {}; // Store current page for each category
  Map<int, bool> isLoading = {}; // Track loading state for each category
  Map<int, bool> hasMore =
      {}; // Track if more data is available for each category

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final quoteProvider = Provider.of<QuoteProvider>(context, listen: false);
      if (!quoteProvider.isLoading) {
        _autoScrollText();
      }
    });
    fetchCategories();
  }
  Future<void> fetchCategories() async {
    final response = await http.get(Uri.parse(
        'https://sabai-job-backend-k9wda.ondigitalocean.app/api/community/categories/'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final List fetchedCategories = jsonDecode(response.body);
      setState(() {
        categoires = fetchedCategories;
      });

      for (var category in categoires) {
        int categoryId = category['id'];
        communityData[categoryId] = [];
        currentPage[categoryId] = 1;
        isLoading[categoryId] = false;
        hasMore[categoryId] = true;
        fetchCommunity(categoryId);
      }
    }
  }

  Future<void> fetchCommunity(int categoryId) async {
    if (isLoading[categoryId] == true || hasMore[categoryId] == false) return;
    setState(() {
      isLoading[categoryId] = true;
    });
    final response = await http.get(Uri.parse(
        'https://sabai-job-backend-k9wda.ondigitalocean.app/api/community/?page=${currentPage[categoryId]}&category=$categoryId'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body);
      setState(() {
        communityData[categoryId]!.addAll(data['results']);
        isLoading[categoryId] = false;
        hasMore[categoryId] = data['next'] != null;
        if (hasMore[categoryId]!) {
          currentPage[categoryId] = currentPage[categoryId]! + 1;
        }
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
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
                "Organizations",
                style: appBarTitleStyleEng,
              )
            : const Text(
                'အဖွဲ့အစည်း',
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
        child: categoires.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryPinkColor,
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                  // const SizedBox(height: 10),
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
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: categoires.map((category) {
                        int categoryId = category['id'];
                        return NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent &&
                                hasMore[categoryId]!) {
                              fetchCommunity(categoryId);
                            }
                            return true;
                          },
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 16,
                            ),
                            itemCount: communityData[categoryId]!.length +
                                (isLoading[categoryId]! ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index >= communityData[categoryId]!.length) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: primaryPinkColor,
                                  ),
                                );
                              }
                              var community = communityData[categoryId]![index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CommunityDetail(id: community['id'],)));
                                  },
                                  subtitle: Text(
                                    community['about'],
                                    maxLines: 1,
                                  ),
                                  subtitleTextStyle: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Bricolage-R',
                                      color: Color(0xFF616971),
                                      overflow: TextOverflow.ellipsis),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  //Placeholder for image
                                  // leading: Container(
                                  //   width: 40,
                                  //   height: 40,
                                  //   color: Colors.grey,
                                  // ),
                                  title: Text(
                                    community['name'],
                                    maxLines: 2,
                                  ),
                                  titleTextStyle: const TextStyle(
                                    fontFamily: 'Bricolage-R',
                                    fontSize: 15.63,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  minTileHeight: 83,
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
