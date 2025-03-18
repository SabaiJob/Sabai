import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/successful_application.dart';
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
        child: categoires.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryPinkColor,
                ),
              )
            : Column(
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
                   Expanded(
                    child: TabBarView(children: [
                      Center(child: InkWell(child: Text('Labor Rights'), onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SuccessfulApplicationScreen()));
                      },)),
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

// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sabai_app/constants.dart';
// import 'package:sabai_app/services/language_provider.dart';
// import 'package:sabai_app/services/quote_provider.dart';

// class CommunityPage extends StatefulWidget {
//   const CommunityPage({super.key});

//   @override
//   State<CommunityPage> createState() => _CommunityPageState();
// }

// class _CommunityPageState extends State<CommunityPage> with SingleTickerProviderStateMixin {
//   final PageController _pageController = PageController();
//   Timer? _timer;
//   int _currentText = 0;
//   TabController? _tabController;
  
//   // Community data state
//   List categories = [];
//   Map<int, List> communitiesByCategory = {};
//   Map<int, int> currentPageByCategory = {};
//   Map<int, bool> isLoadingByCategory = {};
//   Map<int, bool> hasMoreByCategory = {};

//   //motivational quote animation
//   void _autoScrollText() {
//     _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
//       if (mounted) {
//         final quoteProvider =
//             Provider.of<QuoteProvider>(context, listen: false);
//         if (quoteProvider.quotes.isNotEmpty) {
//           setState(() {
//             _currentText = (_currentText + 1) % quoteProvider.quotes.length;
//           });
//           _pageController.animateToPage(
//             _currentText,
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//           );
//         }
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final quoteProvider = Provider.of<QuoteProvider>(context, listen: false);
//       if (!quoteProvider.isLoading) {
//         _autoScrollText();
//       }
//     });
//     fetchCategories();
//   }

//   Future<void> fetchCategories() async {
//     final response = await http.get(Uri.parse(
//         'https://sabai-job-backend-k9wda.ondigitalocean.app/api/community/categories/'));
//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       final fetchedCategories = jsonDecode(response.body);
//       setState(() {
//         categories = fetchedCategories;
        
//         // Initialize data structures for each category
//         for (var category in categories) {
//           int categoryId = category['id'];
//           communitiesByCategory[categoryId] = [];
//           currentPageByCategory[categoryId] = 1;
//           isLoadingByCategory[categoryId] = false;
//           hasMoreByCategory[categoryId] = true;
//         }
//       });
      
//       // Initialize tab controller after categories are loaded
//       _tabController = TabController(length: categories.length, vsync: this);
      
//       // Fetch initial data for the first category
//       if (categories.isNotEmpty) {
//         fetchCommunitiesByCategory(categories[0]['id']);
//       }
      
//       // Add listener to load data when tab changes
//       _tabController?.addListener(() {
//         if (_tabController!.indexIsChanging) return;
        
//         int currentTabIndex = _tabController!.index;
//         if (currentTabIndex < categories.length) {
//           int categoryId = categories[currentTabIndex]['id'];
          
//           // Only fetch if we haven't loaded any data yet
//           if (communitiesByCategory[categoryId]?.isEmpty ?? true) {
//             fetchCommunitiesByCategory(categoryId);
//           }
//         }
//       });
//     }
//   }

//   Future<void> fetchCommunitiesByCategory(int categoryId, {bool refresh = false}) async {
//     // If refreshing, reset pagination
//     if (refresh) {
//       setState(() {
//         currentPageByCategory[categoryId] = 1;
//         communitiesByCategory[categoryId] = [];
//         hasMoreByCategory[categoryId] = true;
//       });
//     }
    
//     // Don't fetch if already loading or no more data
//     if (isLoadingByCategory[categoryId] == true || 
//         hasMoreByCategory[categoryId] == false) {
//       return;
//     }
    
//     setState(() {
//       isLoadingByCategory[categoryId] = true;
//     });
    
//     final int page = currentPageByCategory[categoryId] ?? 1;
//     try {
//       final response = await http.get(Uri.parse(
//           'https://sabai-job-backend-k9wda.ondigitalocean.app/api/community/?page=$page'));
      
//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         final data = jsonDecode(response.body);
//         final results = data['results'] as List;
        
//         // Filter results to only include communities for this category
//         final filteredResults = results.where((community) => 
//           community['id'] == categoryId).toList();
        
//         setState(() {
//           if (communitiesByCategory[categoryId] == null || refresh) {
//             communitiesByCategory[categoryId] = filteredResults;
//           } else {
//             communitiesByCategory[categoryId]?.addAll(filteredResults);
//           }
          
//           currentPageByCategory[categoryId] = page + 1;
//           hasMoreByCategory[categoryId] = data['next'] != null;
//           isLoadingByCategory[categoryId] = false;
//         });
//       } else {
//         setState(() {
//           isLoadingByCategory[categoryId] = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         isLoadingByCategory[categoryId] = false;
//       });
//     }
//   }

//   // Refresh the current tab's data
//   Future<void> refreshCurrentTab() async {
//     if (_tabController == null || categories.isEmpty) return;
    
//     int currentTabIndex = _tabController!.index;
//     if (currentTabIndex < categories.length) {
//       int categoryId = categories[currentTabIndex]['id'];
//       return fetchCommunitiesByCategory(categoryId, refresh: true);
//     }
//   }

//   @override
//   void dispose() {
//     _tabController?.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }

//   // Build community list widget for a specific category
//   Widget _buildCommunityList(int categoryId) {
//     final communities = communitiesByCategory[categoryId] ?? [];
//     final isLoading = isLoadingByCategory[categoryId] ?? false;
//     final hasMore = hasMoreByCategory[categoryId] ?? true;
    
//     return RefreshIndicator(
//       color: primaryPinkColor,
//       onRefresh: () => fetchCommunitiesByCategory(categoryId, refresh: true),
//       child: NotificationListener<ScrollNotification>(
//         onNotification: (ScrollNotification scrollInfo) {
//           if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
//             if (hasMore && !isLoading) {
//               fetchCommunitiesByCategory(categoryId);
//             }
//           }
//           return true;
//         },
//         child: communities.isEmpty && isLoading
//             ? Center(
//                 // This empty Container with ListView.builder ensures the RefreshIndicator works even when empty
//                 child: ListView.builder(
//                   itemCount: 1,
//                   itemBuilder: (context, index) => const Center(
//                     child: Padding(
//                       padding: EdgeInsets.only(top: 100),
//                       child: CircularProgressIndicator(color: primaryPinkColor),
//                     ),
//                   ),
//                 ),
//               )
//             : communities.isEmpty
//                 ? Center(
//                     // This empty Container with ListView.builder ensures the RefreshIndicator works even when empty
//                     child: ListView.builder(
//                       itemCount: 1,
//                       itemBuilder: (context, index) => const Center(
//                         child: Padding(
//                           padding: EdgeInsets.only(top: 100),
//                           child: Text('No communities found. Pull to refresh'),
//                         ),
//                       ),
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: communities.length + (hasMore ? 1 : 0),
//                     itemBuilder: (context, index) {
//                       if (index == communities.length) {
//                         return const Center(
//                           child: Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: CircularProgressIndicator(color: primaryPinkColor),
//                           ),
//                         );
//                       }
                      
//                       final community = communities[index];
//                       return Card(
//                         margin: const EdgeInsets.symmetric(
//                           horizontal: 16, 
//                           vertical: 8,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 community['name'] ?? 'No Name',
//                                 style: const TextStyle(
//                                   fontFamily: 'Bricolage-M',
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 community['about'] ?? 'No description',
//                                 style: const TextStyle(
//                                   fontFamily: 'Bricolage-R',
//                                   fontSize: 14,
//                                 ),
//                                 maxLines: 3,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(height: 8),
//                               TextButton(
//                                 onPressed: () {
//                                   // Navigate to community details or show full description
//                                 },
//                                 child: const Text(
//                                   'Learn More',
//                                   style: TextStyle(
//                                     color: primaryPinkColor,
//                                     fontFamily: 'Bricolage-M',
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var languageProvider = Provider.of<LanguageProvider>(context);
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F7F7),
//       appBar: AppBar(
//         backgroundColor: const Color(0xffF7F7F7),
//         bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(1.0),
//             child: Container(
//               color: Colors.grey.shade300,
//               height: 1.0,
//             )),
//         surfaceTintColor: Colors.transparent,
//         shadowColor: Colors.transparent,
//         title: languageProvider.lan == 'English'
//             ? const Text(
//                 "Community",
//                 style: appBarTitleStyleEng,
//               )
//             : const Text(
//                 'Community',
//                 style: appBarTitleStyleMn,
//               ),
//         centerTitle: true,
//         iconTheme: const IconThemeData(
//           color: Color(0xFFFF3997),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: refreshCurrentTab,
//             color: const Color(0xFFFF3997),
//           ),
//         ],
//       ),
//       body: categories.isEmpty
//           ? const Center(
//               child: CircularProgressIndicator(
//                 color: primaryPinkColor,
//               ),
//             )
//           : Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: SizedBox(
//                     height: 35,
//                     child: Consumer<QuoteProvider>(
//                       builder: (context, quoteProvider, child) {
//                         if (quoteProvider.isLoading) {
//                           return const Center(
//                               child: CircularProgressIndicator(
//                             color: primaryPinkColor,
//                           ));
//                         }
//                         if (quoteProvider.quotes.isEmpty) {
//                           return const Center(
//                             child: Text("No quotes available."),
//                           );
//                         }
//                         return PageView.builder(
//                           scrollDirection: Axis.vertical,
//                           controller: _pageController,
//                           itemCount: quoteProvider.quotes.length,
//                           itemBuilder: (context, index) {
//                             return Row(
//                               children: [
//                                 Image.asset(
//                                   'images/motivation1.png',
//                                   width: 28,
//                                   height: 28,
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Expanded(
//                                   child: Text(
//                                     "${quoteProvider.quotes[index]['text']}",
//                                     style: const TextStyle(
//                                       fontFamily: 'Bricolage-M',
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Container(
//                     height: 33,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF0F1F2),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: TabBar(
//                       controller: _tabController,
//                       tabAlignment: TabAlignment.start,
//                       automaticIndicatorColorAdjustment: true,
//                       isScrollable: true,
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 3, horizontal: 3),
//                       indicatorSize: TabBarIndicatorSize.tab,
//                       indicator: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       labelColor: Colors.pink,
//                       unselectedLabelColor: Colors.pink.shade300,
//                       dividerColor: Colors.transparent,
//                       labelStyle: const TextStyle(
//                         fontSize: 12.5,
//                         color: Color(0xffFF3997),
//                         fontFamily: 'Bricolage-R',
//                       ),
//                       tabs: categories
//                           .map((category) => Tab(text: category['name']))
//                           .toList(),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: TabBarView(
//                     controller: _tabController,
//                     children: categories
//                         .map((category) => _buildCommunityList(category['id']))
//                         .toList(),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }