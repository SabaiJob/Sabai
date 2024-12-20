import 'package:flutter/material.dart';
import 'package:sabai_app/components/reusable_dropdown.dart';
import 'package:sabai_app/constants.dart';

class AdvancedFilterPage extends StatefulWidget {
  const AdvancedFilterPage({super.key});

  @override
  State<AdvancedFilterPage> createState() => _AdvancedFilterPageState();
}

class _AdvancedFilterPageState extends State<AdvancedFilterPage> {
  final List<String> jobNameItems = [
    'Chef',
    'Barista',
    'Teacher',
    'Housekeeper'
  ];
  String? selectedJobName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filters',
          style: appBarTitleStyleEng,
        ),
      ),
      backgroundColor: const Color(0xFFF0F1F2),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: const Align(
                alignment: Alignment.topLeft,
                child:  Text(
                  'Job Name',
                  style: TextStyle(
                    fontFamily: 'Bricolage-M',
                    fontSize: 15.63,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            ReusableDropdown(
              dropdownItems: jobNameItems,
              selectedItem: selectedJobName,
              whenOnChanged: (value) {
                setState(() {
                  selectedJobName = value;
                });
              },
              cusWidth: 400,
              cusHeight: 36,
              hintText: 'Select job name',
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const Align(
                alignment: Alignment.topLeft,
                child:  Text(
                  'Job Category',
                  style: TextStyle(
                    fontFamily: 'Bricolage-M',
                    fontSize: 15.63,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
