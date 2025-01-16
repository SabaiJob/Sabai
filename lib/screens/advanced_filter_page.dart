import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sabai_app/components/reusable_dropdown.dart';
import 'package:sabai_app/components/reusable_radio_button.dart';
import 'package:sabai_app/components/reusable_slider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/data/sabai_app_data.dart';

class AdvancedFilterPage extends StatefulWidget {
  const AdvancedFilterPage({super.key});

  @override
  State<AdvancedFilterPage> createState() => _AdvancedFilterPageState();
}

class _AdvancedFilterPageState extends State<AdvancedFilterPage> {
  Set<int> selectedIndices = {};
  List<Map<String, dynamic>> filteredItems = [];
  Set<Map<String, dynamic>> selectedItems = {};
  final LayerLink _layerLink = LayerLink();
  bool _isDropdownOpen = false;
  // final List<String> jobNameItemsEng = [
  //   'Chef',
  //   'Barista',
  //   'Teacher',
  //   'Housekeeper'
  // ];
  // String? selectedJobName;
  String? selectedJobLocation;
  String? selectedJobTypeOption;
  String? selectedLanguageOption;
  String? selectedVerificationOption;
  double currentValue = 1000.00;

  void toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  String getSelectedItemsText() {
    if (selectedItems.isEmpty) {
      return 'Select job name';
    }
    return selectedItems
        .map((item) => "${item['emoji']} ${item['name']}")
        .join(', ');
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredItems = SabaiAppData().jobCategoryInEng;
  }
  
  @override
  Widget build(BuildContext context) {
    SabaiAppData sabaiAppData = SabaiAppData();
    return Scaffold(
      floatingActionButton: _isDropdownOpen
          ? CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: const Offset(0.0, 40.0),
              child: Material(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                elevation: 2,
                child: Container(
                  width: 343,
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 327,
                        height: 36,
                        child: TextField(
                          autofocus: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.search),
                            prefixIconColor: Colors.pink,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                color: Color(0xFFF0F1F2),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(
                                color: Color(0xFFF0F1F2),
                                width: 1.0,
                              ),
                            ),
                            hintText: 'Search...',
                            hintStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              filteredItems = sabaiAppData.jobCategoryInEng
                                  .where((item) => item['name']
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      LimitedBox(
                        maxHeight: 212,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = filteredItems[index];
                            return CheckboxListTile(
                              activeColor: Colors.pink,
                              checkboxScaleFactor: 0.8,
                              title: Text(
                                "${item['name']} ${item['emoji']}",
                                style: const TextStyle(fontSize: 14),
                              ),
                              value: selectedItems.contains(item),
                              onChanged: (isChecked) {
                                setState(() {
                                  if (isChecked == true) {
                                    selectedItems.add(item);
                                  } else {
                                    selectedItems.remove(item);
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey.shade300,
              height: 1.0,
            )),
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Job Name
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
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
              // TODO to replace with new dropdown that contains search bar
              CompositedTransformTarget(
          link: _layerLink,
          child: GestureDetector(
            onTap: toggleDropdown,
            child: Container(
              width: 343,
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFF0F1F2)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      getSelectedItemsText(),
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Icon(_isDropdownOpen
                      ? CupertinoIcons.chevron_up
                      : CupertinoIcons.chevron_down, color: primaryPinkColor, size: 15,),
                ],
              ),
            ),
          ),
        ),
        
              // Job Category
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                  child: Align(
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
              ),
              // Reusable ChipChoice
              // TODO REFACTOR THIS
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 10.0,
                runSpacing: 1.5,
                children: List.generate(sabaiAppData.jobCategoryInEng.length,
                    (index) {
                  final jobCategory = sabaiAppData.jobCategoryInEng[index];
                  return ChoiceChip(
                    showCheckmark: false,
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          jobCategory['name'],
                          style: const TextStyle(
                              fontFamily: 'Bricolage-R',
                              fontSize: 14,
                              color: Color(0xFF7B838A)),
                        ),
                        Text(
                          jobCategory['emoji'],
                          style: const TextStyle(
                              fontFamily: 'Bricolage-R',
                              fontSize: 14,
                              color: Color(0xFF7B838A)),
                        )
                      ],
                    ),
                    selected: selectedIndices.contains(index),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedIndices.add(index);
                        } else {
                          selectedIndices.remove(index);
                        }
                      });
                    },
                    
                    selectedColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: selectedIndices.contains(index)
                          ? Colors.pink
                          : Colors.transparent,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  );
                }),
              ),
              // Job Location
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Job Location',
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
                dropdownItems: sabaiAppData.provinceItemsInEng,
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
              // Job Type
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
              //Job Type Radio Button
              Row(
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
                ],
              ),
              Row(
                children: [
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
              // Thai Language Requirements
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
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
              // Thai Language Requirements Radio Button
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
              // Salary Range
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
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
              // Salary Range Slider
              ReusableSlider(
                  minAmount: 1000.00,
                  maxAmount: 9000.00,
                  unit: 'THB',
                  currentValue: currentValue,
                  sliderOnChanged: (value) {
                    setState(() {
                      currentValue = value;
                    });
                  }),
              // Verification
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
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
              // Verification Radio Button
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
