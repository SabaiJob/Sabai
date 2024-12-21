import 'package:flutter/material.dart';
import 'package:sabai_app/components/reusable_dropdown.dart';
import 'package:sabai_app/components/reusable_radio_button.dart';
import 'package:sabai_app/constants.dart';

class AdvancedFilterPage extends StatefulWidget {
  const AdvancedFilterPage({super.key});

  @override
  State<AdvancedFilterPage> createState() => _AdvancedFilterPageState();
}

class _AdvancedFilterPageState extends State<AdvancedFilterPage> {
  final List<String> jobNameItemsEng = [
    'Chef',
    'Barista',
    'Teacher',
    'Housekeeper'
  ];
  String? selectedJobName;
  final List<String> jobLocationItemsEng = [
    'Bangkok',
    'Chiang Mai',
    'Chiang Rai',
    'Phuket'
  ];
  String? selectedJobLocation;
  String? selectedJobTypeOption;
  String? selectedLanguageOption;
  String? selectedVerificationOption;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1.0), child: Container(color: Colors.grey.shade300, height: 1.0,)),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          'Filters',
          style: appBarTitleStyleEng,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xffFF3997),
        ),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Job Name',
                      style: TextStyle(
                        fontFamily: 'Bricolage-M',
                        fontSize: 15.63,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              ReusableDropdown(
                dropdownItems: jobNameItemsEng,
                selectedItem: selectedJobName,
                whenOnChanged: (value) {
                  setState(() {
                    selectedJobName = value;
                  });
                },
                cusWidth: 343,
                cusHeight: 36,
                hintText: 'Select job name',
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Job Category',
                    style: TextStyle(
                      fontFamily: 'Bricolage-M',
                      fontSize: 15.63,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border(
                                  top: BorderSide(color: Color(0xFFF0F1F2)),
                                  bottom: BorderSide(color: Color(0xFFF0F1F2)),
                                  left: BorderSide(color: Color(0xFFF0F1F2)),
                                  right: BorderSide(color: Color(0xFFF0F1F2))),
                            ),
                            child: const Text(
                              textAlign: TextAlign.center,
                              'Construction',
                              style: TextStyle(
                                fontFamily: 'Bricolage-R',
                                fontSize: 14,
                                color: Color(0xFF989EA4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border(
                                  top: BorderSide(color: Color(0xFFF0F1F2)),
                                  bottom: BorderSide(color: Color(0xFFF0F1F2)),
                                  left: BorderSide(color: Color(0xFFF0F1F2)),
                                  right: BorderSide(color: Color(0xFFF0F1F2))),
                            ),
                            child: const Text(
                              textAlign: TextAlign.center,
                              'Hospitality',
                              style: TextStyle(
                                fontFamily: 'Bricolage-R',
                                fontSize: 14,
                                color: Color(0xFF989EA4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border(
                                  top: BorderSide(color: Color(0xFFF0F1F2)),
                                  bottom: BorderSide(color: Color(0xFFF0F1F2)),
                                  left: BorderSide(color: Color(0xFFF0F1F2)),
                                  right: BorderSide(color: Color(0xFFF0F1F2))),
                            ),
                            child: const Text(
                              textAlign: TextAlign.center,
                              'Retail',
                              style: TextStyle(
                                fontFamily: 'Bricolage-R',
                                fontSize: 14,
                                color: Color(0xFF989EA4),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border(
                                  top: BorderSide(color: Color(0xFFF0F1F2)),
                                  bottom: BorderSide(color: Color(0xFFF0F1F2)),
                                  left: BorderSide(color: Color(0xFFF0F1F2)),
                                  right: BorderSide(color: Color(0xFFF0F1F2))),
                            ),
                            child: const Text(
                              textAlign: TextAlign.center,
                              'Transportation',
                              style: TextStyle(
                                fontFamily: 'Bricolage-R',
                                fontSize: 14,
                                color: Color(0xFF989EA4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border(
                                  top: BorderSide(color: Color(0xFFF0F1F2)),
                                  bottom: BorderSide(color: Color(0xFFF0F1F2)),
                                  left: BorderSide(color: Color(0xFFF0F1F2)),
                                  right: BorderSide(color: Color(0xFFF0F1F2))),
                            ),
                            child: const Text(
                              textAlign: TextAlign.center,
                              'Cleaning Services',
                              style: TextStyle(
                                fontFamily: 'Bricolage-R',
                                fontSize: 14,
                                color: Color(0xFF989EA4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border(
                                  top: BorderSide(color: Color(0xFFF0F1F2)),
                                  bottom: BorderSide(color: Color(0xFFF0F1F2)),
                                  left: BorderSide(color: Color(0xFFF0F1F2)),
                                  right: BorderSide(color: Color(0xFFF0F1F2))),
                            ),
                            child: const Text(
                              textAlign: TextAlign.center,
                              'Manufacturing',
                              style: TextStyle(
                                fontFamily: 'Bricolage-R',
                                fontSize: 14,
                                color: Color(0xFF989EA4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border(
                                  top: BorderSide(color: Color(0xFFF0F1F2)),
                                  bottom: BorderSide(color: Color(0xFFF0F1F2)),
                                  left: BorderSide(color: Color(0xFFF0F1F2)),
                                  right: BorderSide(color: Color(0xFFF0F1F2))),
                            ),
                            child: const Text(
                              textAlign: TextAlign.center,
                              'Food Services',
                              style: TextStyle(
                                fontFamily: 'Bricolage-R',
                                fontSize: 14,
                                color: Color(0xFF989EA4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border(
                                  top: BorderSide(color: Color(0xFFF0F1F2)),
                                  bottom: BorderSide(color: Color(0xFFF0F1F2)),
                                  left: BorderSide(color: Color(0xFFF0F1F2)),
                                  right: BorderSide(color: Color(0xFFF0F1F2))),
                            ),
                            child: const Text(
                              textAlign: TextAlign.center,
                              'Maintenance',
                              style: TextStyle(
                                fontFamily: 'Bricolage-R',
                                fontSize: 14,
                                color: Color(0xFF989EA4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border(
                                  top: BorderSide(color: Color(0xFFF0F1F2)),
                                  bottom: BorderSide(color: Color(0xFFF0F1F2)),
                                  left: BorderSide(color: Color(0xFFF0F1F2)),
                                  right: BorderSide(color: Color(0xFFF0F1F2))),
                            ),
                            child: const Text(
                              textAlign: TextAlign.center,
                              'Warehouse',
                              style: TextStyle(
                                fontFamily: 'Bricolage-R',
                                fontSize: 14,
                                color: Color(0xFF989EA4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Job Name',
                      style: TextStyle(
                        fontFamily: 'Bricolage-M',
                        fontSize: 15.63,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              ReusableDropdown(
                dropdownItems: jobLocationItemsEng,
                selectedItem: selectedJobLocation,
                whenOnChanged: (value) {
                  setState(() {
                    selectedJobLocation = value;
                  });
                },
                cusWidth: 400,
                cusHeight: 36,
                hintText: 'Select job location',
              ),
              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Job Type',
                      style: TextStyle(
                        fontFamily: 'Bricolage-M',
                        fontSize: 15.63,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Wrap(
                children: [
                  ReusableRadioButton(
                      rButtonValue: 'Remote',
                      rButtonSelectedValue: selectedJobTypeOption,
                      rButtonChoosen: (value) {
                        setState(() {
                          selectedJobTypeOption = value;
                        });
                      },
                      rButtonName: 'Remote'),
                  ReusableRadioButton(
                      rButtonValue: 'Full Time',
                      rButtonSelectedValue: selectedJobTypeOption,
                      rButtonChoosen: (value) {
                        setState(() {
                          selectedJobTypeOption = value;
                        });
                      },
                      rButtonName: 'Full Time'),
                  ReusableRadioButton(
                      rButtonValue: 'Hybrid',
                      rButtonSelectedValue: selectedJobTypeOption,
                      rButtonChoosen: (value) {
                        setState(() {
                          selectedJobTypeOption = value;
                        });
                      },
                      rButtonName: 'Hybrid'),
                  ReusableRadioButton(
                      rButtonValue: 'On Site',
                      rButtonSelectedValue: selectedJobTypeOption,
                      rButtonChoosen: (value) {
                        setState(() {
                          selectedJobTypeOption = value;
                        });
                      },
                      rButtonName: 'On Site'),
                ],
              ),
              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Thai Language Requirement',
                      style: TextStyle(
                        fontFamily: 'Bricolage-M',
                        fontSize: 15.63,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  ReusableRadioButton(
                      rButtonValue: 'Yes',
                      rButtonSelectedValue: selectedLanguageOption,
                      rButtonChoosen: (value) {
                        setState(() {
                          selectedLanguageOption = value;
                        });
                      },
                      rButtonName: 'Yes'),
                  ReusableRadioButton(
                      rButtonValue: 'No',
                      rButtonSelectedValue: selectedLanguageOption,
                      rButtonChoosen: (value) {
                        setState(() {
                          selectedLanguageOption = value;
                        });
                      },
                      rButtonName: 'No'),
                ],
              ),
              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Salary Range',
                      style: TextStyle(
                        fontFamily: 'Bricolage-M',
                        fontSize: 15.63,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              ReusableDropdown(
                dropdownItems: jobLocationItemsEng,
                selectedItem: selectedJobLocation,
                whenOnChanged: (value) {
                  setState(() {
                    selectedJobLocation = value;
                  });
                },
                cusWidth: 343,
                cusHeight: 36,
                hintText: 'Select job location',
              ),
              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Verification',
                      style: TextStyle(
                        fontFamily: 'Bricolage-M',
                        fontSize: 15.63,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  ReusableRadioButton(
                      rButtonValue: 'Yes',
                      rButtonSelectedValue: selectedVerificationOption,
                      rButtonChoosen: (value) {
                        setState(() {
                          selectedVerificationOption = value;
                        });
                      },
                      rButtonName: 'Yes'),
                  ReusableRadioButton(
                      rButtonValue: 'No',
                      rButtonSelectedValue: selectedVerificationOption,
                      rButtonChoosen: (value) {
                        setState(() {
                          selectedVerificationOption = value;
                        });
                      },
                      rButtonName: 'No'),
                ],
              ),
              // SizedBox(
              //   width: 343,
              //   height: 42,
              //   child: TextButton(
              //     onPressed: () {},
              //     style: TextButton.styleFrom(
              //       backgroundColor: const Color(0xffFF3997),
              //       shape: RoundedRectangleBorder(
              //         borderRadius:
              //             BorderRadius.circular(8), // Set the border radius
              //       ),
              //     ),
              //     child: const Text(
              //       'Apply Now',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontFamily: 'Bricolage-B',
              //         fontSize: 15.63,
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Column(
          children: [
            SizedBox(
              width: 343,
              height: 42,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffFF3997),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Set the border radius
                  ),
                ),
                child: const Text(
                  'Apply Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Bricolage-B',
                    fontSize: 15.63,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 343,
              height: 42,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Set the border radius
                  ),
                ),
                child: const Text(
                  'Clear Filter',
                  style: TextStyle(
                    color: Color(0xffFF3997),
                    fontFamily: 'Bricolage-B',
                    fontSize: 15.63,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }
}
