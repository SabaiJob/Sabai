import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_label.dart';
import 'package:sabai_app/components/reusable_radio_button.dart';
import 'package:sabai_app/components/reusable_slider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/data/sabai_app_data.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';
import 'package:sabai_app/screens/auth_pages/api_service.dart';
import 'package:sabai_app/services/jobfilter_provider.dart';
import '../services/job_provider.dart';

class AdvancedFilterPage extends StatefulWidget {
  const AdvancedFilterPage({super.key});

  @override
  State<AdvancedFilterPage> createState() => _AdvancedFilterPageState();
}

class _AdvancedFilterPageState extends State<AdvancedFilterPage> {
  // get job categories
  List<Map<String, dynamic>> _jobCategories = [];
  Future<void> getJobCategory() async {
    try {
      final response = await ApiService.get('/jobs/categories/');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = json.decode(response.body);
        final List<Map<String, dynamic>> jobCategories = data.map((job) {
          String name = job['name'];
          String imageLink = job['image'];
          int id = job['id'];
          return {
            'name': name ?? 'Unknown',
            'image': imageLink ?? '',
            'selected': false,
            'id': id,
          };
        }).toList();
        setState(() {
          _jobCategories = jobCategories;
        });
      } else {
        print('error: ${response.body} , ststusCode: ${response.statusCode} ');
      }
    } catch (e) {
      print(e);
    }
  }

  SabaiAppData sabaiAppData = SabaiAppData();
  // Variables to store selected filter values
  List<dynamic> selectedJobNames = [];
  List<int> selectedJobCategoryIndices = [];
  List<dynamic> selectedJobLocations = [];
  List<int> selectedJobTypeIndices = [];
  String? selectedLanguageOption;
  String? Value;
  String? selectedVerificationOption;
  double currentValue = 1000.00;

  // Method to collect all selected filter values
  Map<String, dynamic> collectFilterValues() {
    return {
      'jobNames': selectedJobNames,
      'jobCategories': selectedJobCategoryIndices
          .map((index) => _jobCategories[index]['id'])
          .toList(),
      'jobLocations': selectedJobLocations,
      'jobTypes': selectedJobTypeIndices
          .map((index) => sabaiAppData.jobTypes[index])
          .toList(),
      'thaiLanguageRequired': selectedLanguageOption == 'Yes'
          ? true
          : selectedLanguageOption == 'No'
              ? false
              : null,
      'verificationRequired': selectedVerificationOption == 'Yes'
          ? true
          : selectedVerificationOption == 'No'
              ? false
              : null,
      'salaryRange': currentValue,
    };
  }

  // Method to clear all filters
  void clearFilters() {
    setState(() {
      selectedJobNames.clear();
      selectedJobCategoryIndices.clear();
      selectedJobLocations.clear();
      selectedJobTypeIndices.clear();
      selectedLanguageOption = null; // Reset to null
      selectedVerificationOption = null; // Reset to null
      currentValue = 1000.00;
    });
    Provider.of<JobFilterProvider>(context, listen: false).setFilter(false);
    // Clear filters in the provider
    Provider.of<JobFilterProvider>(context, listen: false)
        .updateFilterValues(null);

    // Navigate back to the JobListingPage
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const NavigationHomepage()),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    selectedJobNames.clear();
    selectedJobCategoryIndices.clear();
    selectedJobLocations.clear();
    selectedJobTypeIndices.clear();
    selectedLanguageOption = null; // Reset to null
    selectedVerificationOption = null; // Reset to null
    currentValue = 1000.00;
    print('name : $selectedJobNames');
    getJobCategory();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final filterProvider =
          Provider.of<JobFilterProvider>(context, listen: false);
      //
      // filterProvider.filterValues?.clear();
      // filterProvider.updateFilterValues(null);
      //filterProvider.updateFilterJobName();
      filterProvider.setFilter(false);
      filterProvider.clearAllFilters();
      filterProvider.clearFilters();
      //
      final existingFilters = filterProvider.filterValues;
      //
      final jobProvider = Provider.of<JobProvider>(context, listen: false);
      jobProvider.getAllJobs();

      if (existingFilters != null) {
        setState(() {
          selectedJobNames = existingFilters['jobNames'] ?? [];
          selectedJobCategoryIndices = existingFilters['jobCategories'] != null
              ? List.generate(
                  existingFilters['jobCategories'].length,
                  (index) => _jobCategories.indexWhere(
                    (cat) =>
                        cat['id'] == existingFilters['jobCategories'][index],
                  ),
                ).where((index) => index != -1).toList()
              : [];
          selectedJobLocations = existingFilters['jobLocations'] ?? [];
          selectedJobTypeIndices = existingFilters['jobTypes'] != null
              ? List.generate(
                  existingFilters['jobTypes'].length,
                  (index) => sabaiAppData.jobTypes
                      .indexOf(existingFilters['jobTypes'][index]),
                ).where((index) => index != -1).toList()
              : [];

          // Restore radio button values (handle null)
          selectedLanguageOption =
              existingFilters['thaiLanguageRequired'] == true
                  ? 'Yes'
                  : existingFilters['thaiLanguageRequired'] == false
                      ? 'No'
                      : null;
          selectedVerificationOption =
              existingFilters['verificationRequired'] == true
                  ? 'Yes'
                  : existingFilters['verificationRequired'] == false
                      ? 'No'
                      : null;

          currentValue = existingFilters['salaryRange'] ?? 1000.00;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SabaiAppData sabaiAppData = SabaiAppData();
    var jobProvider = Provider.of<JobProvider>(context);
    final allJobs = jobProvider.allTypeJobs
        .where((job) => job['type'] == 'job')
        .map((job) => job['info']['title'])
        .toList();
    var jobNameItems = jobProvider.allTypeJobs
        .where((job) => job['type'] == 'job')
        .map((job) => DropdownItem(
            label: '${job['info']['title']}', value: '${job['info']['title']}'))
        .toList();
    var jobLocation = sabaiAppData.provinceItemsInEng
        .map((province) => DropdownItem(label: province, value: province))
        .toList();
    if (_jobCategories.isEmpty || jobProvider.isLoading) {
      return const Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: CircularProgressIndicator(
            color: primaryPinkColor,
          ),
        ),
      );
    }
    return Scaffold(
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
                child: ReusableLabelHolder(
                    labelName: 'Job Name',
                    textStyle: lablelHolderEng,
                    isStarred: false),
              ),
              // Job Name Dropdown with search bar
              SizedBox(
                width: 343,
                child: MultiDropdown(
                  singleSelect: true,
                  onSelectionChange: (selectedItems) {
                    setState(() {
                      selectedJobNames = selectedItems;
                    });
                  },
                  enabled: true,
                  items: jobNameItems,
                  fieldDecoration: const FieldDecoration(
                    backgroundColor: Colors.white,
                    hintText: 'Select Job Name',
                    hintStyle: textfieldHintTextStyleEng,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                        color: Color(0xFFF0F1F2),
                      ),
                    ),
                  ),
                  searchEnabled: true,
                  searchDecoration: const SearchFieldDecoration(
                    searchIcon: Icon(
                      Icons.search,
                      color: primaryPinkColor,
                    ),
                    hintText: 'Search Job By Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                        color: Color(0xFFF0F1F2),
                      ),
                    ),
                  ),
                  chipDecoration: const ChipDecoration(
                    wrap: true,
                    spacing: 8,
                    runSpacing: 10,
                    deleteIcon: Icon(
                      Icons.close,
                      size: 11,
                      color: primaryPinkColor,
                    ),
                    labelStyle: TextStyle(
                      fontFamily: 'Bricolage-R',
                      fontSize: 12,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  dropdownDecoration: const DropdownDecoration(
                    marginTop: 5,
                    maxHeight: 212,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  dropdownItemDecoration: const DropdownItemDecoration(
                      selectedIcon: Icon(
                    Icons.check_box,
                    size: 20,
                    color: primaryPinkColor,
                  )),
                ),
              ),
              // Job Category
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: ReusableLabelHolder(
                    labelName: 'Job Category',
                    textStyle: lablelHolderEng,
                    isStarred: false),
              ),
              // Job Category
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 10.0,
                runSpacing: 1.5,
                children: List.generate(_jobCategories.length, (index) {
                  final jobCategory = _jobCategories[index];
                  return ChoiceChip(
                    showCheckmark: false,
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          jobCategory['name'],
                          style: choiceChipItemStyle,
                        ),
                        Image.network(
                          jobCategory['image'],
                          width: 15,
                          height: 15,
                        ),
                      ],
                    ),
                    selected: selectedJobCategoryIndices.contains(index),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedJobCategoryIndices.add(index);
                        } else {
                          selectedJobCategoryIndices.remove(index);
                        }
                      });
                    },
                    selectedColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: selectedJobCategoryIndices.contains(index)
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
                child: ReusableLabelHolder(
                    labelName: 'Job Location',
                    textStyle: lablelHolderEng,
                    isStarred: false),
              ),
              //Job Location dropdown
              SizedBox(
                width: 343,
                child: MultiDropdown(
                  singleSelect: true,
                  onSelectionChange: (selectedItems) {
                    setState(() {
                      selectedJobLocations = selectedItems;
                    });
                  },
                  enabled: true,
                  items: jobLocation,
                  fieldDecoration: const FieldDecoration(
                    backgroundColor: Colors.white,
                    hintText: 'Select Job Location',
                    hintStyle: textfieldHintTextStyleEng,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                        color: Color(0xFFF0F1F2),
                      ),
                    ),
                  ),
                  searchEnabled: true,
                  searchDecoration: const SearchFieldDecoration(
                    searchIcon: Icon(
                      Icons.search,
                      color: primaryPinkColor,
                    ),
                    hintText: 'Search Job By Province',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                        color: Color(0xFFF0F1F2),
                      ),
                    ),
                  ),
                  chipDecoration: const ChipDecoration(
                    wrap: true,
                    spacing: 8,
                    runSpacing: 10,
                    deleteIcon: Icon(
                      Icons.close,
                      size: 11,
                      color: primaryPinkColor,
                    ),
                    labelStyle: TextStyle(
                      fontFamily: 'Bricolage-R',
                      fontSize: 12,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  dropdownDecoration: const DropdownDecoration(
                    marginTop: 5,
                    maxHeight: 212,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  dropdownItemDecoration: const DropdownItemDecoration(
                      selectedIcon: Icon(
                    Icons.check_box,
                    size: 20,
                    color: primaryPinkColor,
                  )),
                ),
              ),
              // Job Type
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: ReusableLabelHolder(
                    labelName: 'Job Type',
                    textStyle: lablelHolderEng,
                    isStarred: false),
              ),
              //Job Type Radio Button
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 10.0,
                runSpacing: 1.5,
                children: List.generate(sabaiAppData.jobTypes.length, (index) {
                  final jobType = sabaiAppData.jobTypes[index];
                  return ChoiceChip(
                    showCheckmark: false,
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          jobType,
                          style: choiceChipItemStyle,
                        ),
                      ],
                    ),
                    selected: selectedJobTypeIndices.contains(index),
                    // onSelected: (selected) {
                    //   setState(() {
                    //     if (selected) {
                    //       selectedJobTypeIndices = [index];
                    //     } else {
                    //       selectedJobTypeIndices.clear();
                    //     }
                    //   });
                    // },
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedJobTypeIndices.add(index);
                        } else {
                          selectedJobTypeIndices.remove(index);
                        }
                      });
                    },
                    selectedColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: selectedJobTypeIndices.contains(index)
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
              // Thai Language Requirements
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: ReusableLabelHolder(
                    labelName: 'Thai Language Requirement',
                    textStyle: lablelHolderEng,
                    isStarred: false),
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
                          print(selectedLanguageOption);
                        });
                      },
                      rButtonName: 'No'),
                ],
              ),
              // Salary Range
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: ReusableLabelHolder(
                    labelName: 'Salary Range',
                    textStyle: lablelHolderEng,
                    isStarred: false),
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
                child: ReusableLabelHolder(
                    labelName: 'Verification',
                    textStyle: TextStyle(
                      fontFamily: 'Bricolage-M',
                      fontSize: 15.63,
                      color: Colors.black,
                    ),
                    isStarred: false),
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
                onPressed: () {
                  // Collect and use filter values
                  final filterValues = collectFilterValues();
                  print(filterValues); // Or pass to another screen/function
                  print(selectedJobLocations);

                  if (filterValues.isEmpty) {
                    Provider.of<JobFilterProvider>(context, listen: false)
                        .setFilter(false);
                    // Navigate back
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NavigationHomepage()));
                  } else if (selectedJobNames.isEmpty &&
                      selectedJobCategoryIndices.isEmpty &&
                      selectedJobLocations.isEmpty &&
                      selectedJobTypeIndices.isEmpty &&
                      selectedLanguageOption != 'Yes' &&
                      selectedVerificationOption != 'Yes') {
                    Provider.of<JobFilterProvider>(context, listen: false)
                        .setFilter(false);
                    // Navigate back
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NavigationHomepage()));
                  } else {
                    final jobFilterProvider =
                        Provider.of<JobFilterProvider>(context, listen: false);
                    jobFilterProvider.updateFilterValues(filterValues);
                    print('it works');

                    // Use Provider to update filter values
                    Provider.of<JobFilterProvider>(context, listen: false)
                        .updateFilterValues(filterValues);
                    print('the above is worked 1!');
                    Provider.of<JobFilterProvider>(context, listen: false)
                        .setFilter(true);
                    print('the above is worked 2!');
                    if (selectedJobCategoryIndices.isNotEmpty) {
                      Provider.of<JobFilterProvider>(context, listen: false)
                          .setCategory(filterValues['jobCategories'].join(','));
                      print(filterValues['jobCategories'].join(','));
                    }
                    print('the above is worked 3!');
                    print(selectedJobNames.length);
                    if (selectedJobNames.isNotEmpty) {
                      Provider.of<JobFilterProvider>(context, listen: false)
                          .setTitle('${selectedJobNames[0]}');
                    }
                    print('the above is worked 4!');
                    if (selectedJobLocations.isNotEmpty) {
                      Provider.of<JobFilterProvider>(context, listen: false)
                          .setLocation('${filterValues['jobLocations'][0]}');
                    }
                    print('the above is worked 5!');
                    if (selectedJobTypeIndices.isNotEmpty) {
                      Provider.of<JobFilterProvider>(context, listen: false)
                          .setType('${filterValues['jobTypes'][0]}');
                      // print(filterValues['jobTypes'][0]);
                    }
                    print('the above is worked 6!');
                    if (selectedLanguageOption != null) {
                      Provider.of<JobFilterProvider>(context, listen: false)
                          .setThaiReq(filterValues['thaiLanguageRequired']);
                    }
                    print('the above is worked 7!');
                    // Provider.of<JobFilterProvider>(context, listen: false)
                    //     .setMinSalary(1000);
                    if (currentValue != 1000) {
                      Provider.of<JobFilterProvider>(context, listen: false)
                          .setMAxSalary(currentValue.toInt());
                    }

                    if (selectedVerificationOption != null) {
                      Provider.of<JobFilterProvider>(context, listen: false)
                          .setVerified(filterValues['verificationRequired']);
                    }
                    // Navigate back
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NavigationHomepage()));
                  }
                },
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
                onPressed: clearFilters,
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
