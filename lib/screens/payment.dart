import 'package:flutter/material.dart';
import 'package:sabai_app/components/reusable_textformfield.dart';
import 'package:sabai_app/constants.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Upgrade to premium',style: appBarTitleStyleEng,),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: backgroundColor,
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1), child: Container(
          height: 1,
          color: Colors.grey.shade300,
        ),),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
        
            ],
          ),
        ),
      ),
    );
  }
}