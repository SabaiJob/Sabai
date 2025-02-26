import 'package:flutter/material.dart';

class ComingSoonPage extends StatelessWidget {
  final Widget? appBarTitle;
  const ComingSoonPage({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        backgroundColor: const Color(0xFFFFEBF6),
      ),
      backgroundColor:  const Color(0xFFFFEBF6),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Coming Soon🚀', style: TextStyle(
            fontSize: 19.53,
            fontFamily: 'Bricolage-SMB',
            color: Colors.black,
          ),),
          Text('We’re working hard to bring you something amazing. Stay tuned!', style: TextStyle(
            fontSize: 15.6,
            fontFamily: 'Bricolage-R',
            color: Color(0xFF6C757D),
          ),)
        ],
      ),
    );
  }
}