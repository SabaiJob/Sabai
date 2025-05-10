import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/auth_pages/api_service.dart';
import 'package:sabai_app/services/general_provider.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Future<void> loadNotification() async {
    final generalProvider =
        Provider.of<GeneralProvider>(context, listen: false);
    await generalProvider.loadNotification();
  }

  Map<String, List<Map<String, dynamic>>> groupNotifications(
      List<Map<String, dynamic>> notifications) {
    final now = DateTime.now();
    final today = DateFormat('yyyy-MM-dd').format(now);
    final yesterday = DateFormat('yyyy-MM-dd').format(
      now.subtract(
        const Duration(days: 1),
      ),
    );

    final groupedNoti = <String, List<Map<String, dynamic>>>{};

    for (var noti in notifications) {
      final notiDate = DateTime.parse(noti['time']);
      final formattedDate = DateFormat('yyyy-MM-dd').format(notiDate);

      if (formattedDate == today) {
        groupedNoti.putIfAbsent('Today', () => []).add(noti);
      } else if (formattedDate == yesterday) {
        groupedNoti.putIfAbsent('Yesterday', () => []).add(noti);
      } else {
        groupedNoti
            .putIfAbsent(DateFormat('MMMM dd').format(notiDate), () => [])
            .add(noti);
      }
    }

    return groupedNoti;
  }

  String timeAgo(String timestamp) {
    final notificationTime = DateTime.parse(timestamp);
    final now = DateTime.now();
    final difference = now.difference(notificationTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMMM dd').format(notificationTime);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Future.microtask(() => loadNotification());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadNotification();
    });
    //print(noti);
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var generalProvider = Provider.of<GeneralProvider>(context);
    final noti = generalProvider.noti;
    final groupedNoti = groupNotifications(noti);
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F7F7),
        title: languageProvider.lan == 'English'
            ? const Text(
                "Notifications",
                style: TextStyle(
                  fontFamily: 'Bricolage-M',
                  fontSize: 19.53,
                ),
              )
            : const Text(
                "အသိပေးချက်များ",
                style: TextStyle(
                  fontFamily: 'Walone-B',
                  fontSize: 19.53,
                ),
              ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: primaryPinkColor,
        ),
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const NavigationHomepage(
        //           showButtonSheet: false,
        //         ),
        //       ),
        //     );
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back,
        //     color: Color(0xffFF3997),
        //   ),
        // ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade300,
            height: 1.0,
          ),
        ),
      ),
      body: generalProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryPinkColor,
              ),
            )
          : Center(
              child: noti.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/notification.png',
                          width: 168,
                          height: 298,
                        ),
                        languageProvider.lan == 'English'
                            ? const Text(
                                "You're all caught up!",
                                style: TextStyle(
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 24.41,
                                ),
                              )
                            : const Text(
                                "အသိပေးချက်အသစ်မရှိပါ",
                                style: TextStyle(
                                  fontFamily: 'Walone-B',
                                  fontSize: 24.41,
                                ),
                              ),
                        languageProvider.lan == 'English'
                            ? const Text(
                                "Check back later for updates.",
                                style: TextStyle(
                                  fontFamily: 'Bricolage-R',
                                  fontSize: 15.63,
                                ),
                              )
                            : const Text(
                                "နောက်ပိုင်းတွင် အပ်ဒိတ်များအတွက် ပြန်လည်စစ်ဆေးပါ။",
                                style: TextStyle(
                                  fontFamily: 'Walone-B',
                                  fontSize: 14,
                                ),
                              )
                      ],
                    )
                  : ListView(
                      children: groupedNoti.entries.map(
                        (entry) {
                          final header = entry.key;
                          final items = entry.value;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 13),
                                child: Text(
                                  header,
                                  style: const TextStyle(
                                    fontFamily: 'Bricolage-R',
                                    fontSize: 15.63,
                                    color: Color(0xFF41464B),
                                  ),
                                ),
                              ),
                              ...items.map(
                                (item) => NotiTile(
                                  title: item['title']!,
                                  time: timeAgo(item['time']!),
                                  type: item['type']!.toString().toLowerCase(),
                                ),
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    ),
            ),
    );
  }
}

class NotiTile extends StatelessWidget {
  const NotiTile({
    required this.title,
    required this.time,
    required this.type,
    super.key,
  });

  final String title;
  final String time;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: ListTile(
        minTileHeight: 82,
        titleAlignment: ListTileTitleAlignment.titleHeight,
        leading: type.toLowerCase() == 'payment_success' ||
                type.toLowerCase() == 'contribution_success'
            ? Image.asset('images/like.png')
            : type.toLowerCase() == 'reminder'
                ? Image.asset('images/noti_closing.png')
                : type.toLowerCase() == 'quote'
                    ? Image.asset('images/noti_moti.png')
                    : type.toLowerCase() == 'reward'
                        ? Image.asset('images/noti_rose.png')
                        : type.toLowerCase() == 'job'
                            ? Image.asset('images/noti_open.png')
                            : type.toLowerCase() == 'contribution'
                                ? Image.asset('images/noti_clock')
                                :
                                //type.toLowerCase() == 'payment_fail' || type.toLowerCase() == 'contribution_fail'?
                                Image.asset('images/sad.png'),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Bricolage-M',
                fontSize: 13,
                color: Color(0xff363B3F),
              ),
            ),
            type.toLowerCase() == 'contribute'
                ? const Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                          child: Image(
                        image: AssetImage('images/avatar1.png'),
                        width: 24,
                        height: 24,
                      )),
                      Positioned(
                          left: 12,
                          child: Image(
                            image: AssetImage('images/avatar2.png'),
                            width: 24,
                            height: 24,
                          )),
                      Positioned(
                          left: 24,
                          child: Image(
                            image: AssetImage('images/avatar3.png'),
                            width: 24,
                            height: 24,
                          )),
                      Positioned(
                          left: 36,
                          child: Image(
                            image: AssetImage('images/avatar4.png'),
                            width: 24,
                            height: 24,
                          )),
                    ],
                  )
                : const SizedBox(
                    height: 5,
                  ),
            Text(
              time,
              style: const TextStyle(
                fontFamily: 'Bricolage-R',
                fontSize: 11,
                color: Color(0xFFB6BABE),
              ),
            ),
          ],
        ),
        trailing: const Icon(
          Icons.more_vert,
          color: primaryPinkColor,
          size: 12,
        ),
      ),
    );
  }
}
