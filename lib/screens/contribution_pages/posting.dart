import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/bottom_navi_pages/job_listing_page.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';

class Posting extends StatelessWidget {
  Posting({this.url, this.img, super.key});

  String? url = '';
  String? img = '';

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse(url!);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          'Post',
          style: appBarTitleStyleEng,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: primaryPinkColor,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextButton(
              style: TextButton.styleFrom(
                  minimumSize: const Size(82, 29),
                  backgroundColor: primaryPinkColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  )),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NavigationHomepage(),
                  ),
                );
              },
              child: const Text(
                'Contribute',
                style: TextStyle(
                  fontFamily: 'Bricolage-B',
                  fontSize: 12.5,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey.shade300,
            height: 1,
          ),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
