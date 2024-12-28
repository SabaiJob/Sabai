import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, dynamic>> noti = [
    {
      'img': 'images/noti_moti.png',
      'title':
          '“Success is not the result of spontaneous combustion. You must set yourself on fire."\nby Arnold H. Glasow',
      'time': '2024-12-27T14:00:00Z',
      'type': 'none',
    },
    {
      'img': 'images/noti_closing.png',
      'title':
          '⏰ Hurry! Your Barista position is closing soon! Apply before it\'s too late!',
      'time': '2024-12-27T13:50:00Z',
      'type': 'none',
    },
    {
      'img': 'images/noti_open.png',
      'title':
          'New positions for Barista in are now open. Check them out and apply today! 🎉',
      'time': '2024-12-26T15:30:00Z',
      'type': 'none',
    },
    {
      'img': 'images/noti_rose.png',
      'title': 'You received 6 roses for your contribution from',
      'time': '2024-12-26T14:00:00Z',
      'type': 'contribute',
    }
  ];

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
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
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
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NavigationHomepage(
                  showButtonSheet: false,
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xffFF3997),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade300,
            height: 1.0,
          ),
        ),
      ),
      body: Center(
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
                            img: item['img']!,
                            title: item['title']!,
                            time: timeAgo(item['time']!),
                            type: item['type']!,
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
    required this.img,
    required this.title,
    required this.time,
    required this.type,
    super.key,
  });

  final String img;
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
        leading: Image.asset(img),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Bricolage-R',
                fontSize: 10,
                color: Color(0xff363B3F),
              ),
            ),
            type == 'contribute'
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
                fontSize: 10,
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
