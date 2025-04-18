import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_bulletpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:sabai_app/components/tc_dialog.dart';
import 'package:sabai_app/components/work_card.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/auth_pages/api_service.dart';
import 'package:sabai_app/services/language_provider.dart';

class JobDetailsPage extends StatefulWidget {
  const JobDetailsPage(
      {super.key, required this.jobId, required this.isClosed});
  final int jobId;
  final bool isClosed;

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  late Map<String, dynamic> jobDetail;
  late List<dynamic> interestedUser;
  bool isLoading = true;
  Future<void> fetchJobDetail() async {
    try {
      final response = await ApiService.get('/jobs/${widget.jobId}/');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          jobDetail = data['job'];
          interestedUser = data['job']['interested_by']['users'];
          isLoading = false;
          //print(jobDetail);
        });
      } else {
        print('Fetching error: ${response.body}');
      }
    } catch (e) {
      print(e);
    }
  }

  List<dynamic> _jobCategories = [];
  Future<void> fetchCategory() async {
    try {
      final response = await ApiService.get('/jobs/categories/');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        setState(() {
          _jobCategories = json.decode(response.body);
          //print(_jobCategories[0]);
        });
      } else {
        print('Fetching error: ${response.body}');
      }
    } catch (e) {
      print(e);
    }
  }

  // Function to get category name by ID
  String getCategoryNameById(int id) {
    // Search through the list to find the matching category
    for (final category in _jobCategories) {
      //print('category : $category');
      if (category['id'] == 1) {
        return category['name'];
      }
    }

    // Return a default value if no matching category is found
    return "Unknown Category";
  }

  @override
  void initState() {
    super.initState();
    fetchJobDetail();
    fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F1F2),
        title: const Text(
          'Job Details',
          style: appBarTitleStyleEng,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xffFF3997),
        ),
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(1.0), // Height of the bottom border
          child: Container(
            color: Colors.grey.shade300, // Border color
            height: 1.0, // Border thickness
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryPinkColor,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${jobDetail['title']}',
                      style: const TextStyle(
                        fontSize: 24.41,
                        fontFamily: 'Bricolage-M',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 400,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Sabai Job Partner Tag
                          jobDetail['is_partner'] == true
                              ? Container(
                                  width: 130,
                                  height: 21,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFEBF6),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(8),
                                        topLeft: Radius.circular(8)),
                                  ),
                                  child: Row(
                                    children: [
                                      const Image(
                                        image: AssetImage('images/status.png'),
                                        width: 12,
                                        height: 12,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      languageProvider.lan == 'English'
                                          ? const Text(
                                              'Sabai Job Partner',
                                              style: TextStyle(
                                                  fontFamily: 'Bricolage-R',
                                                  fontSize: 12.5,
                                                  //color: Color(0xFF6C757D),
                                                  ),
                                            )
                                          : RichText(
                                              text: const TextSpan(
                                                text: 'Sabai Job  ',
                                                style: TextStyle(
                                                  fontFamily: 'Bricolage-R',
                                                  fontSize: 10,
                                                 // color: Color(0xFF6C757D),
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: 'မိတ်ဖက်',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontFamily: 'Walone-B',
                                                      //color: Color(0xFF6C757D),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
                                )
                              : const SizedBox(
                                  height: 10,
                                ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Offered by',
                                      style: TextStyle(
                                        //color: Color(0xFF6C757D),
                                        fontFamily: 'Walone-R',
                                        fontSize: 12.5,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${jobDetail['company_name']}',
                                      style: const TextStyle(
                                        //color: Color(0xFF4C5258),
                                        fontFamily: 'Walone-B',
                                        fontSize: 15.63,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    languageProvider.lan == 'English'
                                        ? const Text(
                                            'Salary',
                                            style: TextStyle(
                                             // color: Color(0xFF6C757D),
                                              fontFamily: 'Walone-R',
                                              fontSize: 12.5,
                                            ),
                                          )
                                        : const Text(
                                            'လစာ',
                                            style: TextStyle(
                                              fontFamily: 'Walone-R',
                                              fontSize: 12.5,
                                             // color: Color(0xff6C757D),
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    languageProvider.lan == 'English'
                                        ? Text(
                                            '${jobDetail['salary_min']} ~ ${jobDetail['salary_max']} ${jobDetail['currency']}',
                                            style: const TextStyle(
                                             // color: Color(0xFF4C5258),
                                              fontFamily: 'Walone-B',
                                              fontSize: 15.63,
                                            ),
                                          )
                                        : const Text(
                                            '၁၈၀၀၀ ~ ၂၈၀၀၀ ဘတ်',
                                            style: TextStyle(
                                              fontFamily: 'Walone-B',
                                              fontSize: 15.63,
                                             // color: Color(0xff4C5258),
                                            ),
                                          ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    languageProvider.lan == 'English'
                                        ? const Text(
                                            'Safety',
                                            style: TextStyle(
                                              //color: Color(0xFF6C757D),
                                              fontFamily: 'Walone-R',
                                              fontSize: 12.5,
                                            ),
                                          )
                                        : const Text(
                                            'စိတ်ချရမှု',
                                            style: TextStyle(
                                              fontFamily: 'Walone-R',
                                              fontSize: 12.5,
                                              //color: Color(0xff6C757D),
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: 80,
                                      child: JobLevelCard(
                                        language: languageProvider,
                                        level: jobDetail['safety_level'],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    languageProvider.lan == 'English'
                                        ? const Text(
                                            'Location',
                                            style: TextStyle(
                                             // color: Color(0xFF6C757D),
                                              fontFamily: 'Walone-R',
                                              fontSize: 12.5,
                                            ),
                                          )
                                        : const Text(
                                            'တည်နေရာ',
                                            style: TextStyle(
                                              fontFamily: 'Walone-R',
                                              fontSize: 12.5,
                                              //color: Color(0xff6C757D),
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text('${jobDetail['location']}',
                                        style: const TextStyle(
                                         // color: Color(0xFF4C5258),
                                          fontFamily: 'Walone-B',
                                          fontSize: 15.63,
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Job Category',
                                      style: TextStyle(
                                        //color: Color(0xFF6C757D),
                                        fontFamily: 'Walone-R',
                                        fontSize: 12.5,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      //'${jobDetail['category']}',
                                      getCategoryNameById(
                                          jobDetail['category']),
                                      style: const TextStyle(
                                        color: Color(0xFF4C5258),
                                        fontFamily: 'Bricolage-M',
                                        fontSize: 15.63,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Job Type',
                                      style: TextStyle(
                                      
                                        fontFamily: 'Walone-R',
                                        fontSize: 12.5,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${jobDetail['job_type']}',
                                      style: const TextStyle(
                                    
                                        fontFamily: 'Walone-B',
                                        fontSize: 15.63,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    languageProvider.lan == 'English'
                        ? const Text(
                            'Job Summary',
                            style: TextStyle(
                              fontSize: 15.63,
                              fontFamily: 'Walone-B',
                              color: Color(0xFF363B3F),
                            ),
                          )
                        : const Text(
                            'အလုပ်အကျဉ်း',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Walone-B',
                              color: Color(0xFF363B3F),
                            ),
                          ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      '${jobDetail['job_summary']}',
                      style: const TextStyle(
                        fontFamily: 'Walone-R',
                       // color: Color(0xFF4C5258),
                        fontSize: 15.63,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    languageProvider.lan == 'English'
                        ? const Text(
                            'Responsibilities',
                            style: TextStyle(
                              fontSize: 15.63,
                              fontFamily: 'Walone-B',
                              color: Color(0xFF363B3F),
                            ),
                          )
                        : const Text(
                            'အဓိကတာဝန်များ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Walone-B',
                              color: Color(0xFF363B3F),
                            ),
                          ),
                    const SizedBox(
                      height: 12,
                    ),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: jobDetail['key_responsibilities'].length,
                      itemBuilder: (context, index) {
                        return ReusableBulletPoints(
                            content:
                                '${jobDetail['key_responsibilities'][index]}');
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    languageProvider.lan == 'English'
                        ? const Text(
                            'Qualifications',
                            style: TextStyle(
                              fontSize: 15.63,
                              fontFamily: 'Walone-B',
                              color: Color(0xFF363B3F),
                            ),
                          )
                        : const Text(
                            'လိုအပ်သောအရည်အချင်းများ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Walone-B',
                              color: Color(0xFF363B3F),
                            ),
                          ),
                    const SizedBox(
                      height: 12,
                    ),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: jobDetail['qualifications'].length,
                      itemBuilder: (context, index) {
                        return ReusableBulletPoints(
                            content: '${jobDetail['qualifications'][index]}');
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      width: double.infinity,
                      height: 170,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Color(0xFFE2E3E5),
                            width: 2.0,
                          ),
                          bottom: BorderSide(
                            color: Color(0xFFE2E3E5),
                            width: 2.0,
                          ),
                          left: BorderSide(
                            color: Color(0xFFE2E3E5),
                            width: 2.0,
                          ),
                          right: BorderSide(
                            color: Color(0xFFE2E3E5),
                            width: 2.0,
                          ),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              languageProvider.lan == 'English'
                                  ? const Text(
                                      'Contributed by',
                                      style: TextStyle(
                                        //color: Color(0xFF6C757D),
                                        fontFamily: 'Walone-B',
                                        fontSize: 13,
                                      ),
                                    )
                                  : const Text(
                                      'အလုပ်တင်ပေးသူ',
                                      style: TextStyle(
                                        //color: Color(0xFF6C757D),
                                        fontFamily: 'Walone-B',
                                        fontSize: 10,
                                      ),
                                    ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFE2E3E5),
                                    width: 2.0,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                ),
                                width: 100,
                                height: 25,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Image(
                                      image: AssetImage('images/rose.png'),
                                      width: 12,
                                      height: 15.26,
                                    ),
                                    languageProvider.lan == 'English'
                                        ? const Text(
                                            'Say Thanks',
                                            style: TextStyle(
                                              fontFamily: 'Walone-B',
                                              fontSize: 10,
                                              color: Color(0xFFFF4DA1),
                                            ),
                                          )
                                        : const Text(
                                            'ကျေးဇူးတင်ပါသည် ',
                                            style: TextStyle(
                                              fontFamily: 'Walone-B',
                                              fontSize: 10,
                                              color: Color(0xFFFF4DA1),
                                            ),
                                          )
                                  ],
                                ),
                              )
                            ],
                          ),
                          jobDetail['contribution'] == null
                              ? const Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Image(
                                      image: AssetImage('images/status.png'),
                                      width: 24,
                                      height: 24,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Sabai',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Walone-R',
                                        //color: Color(0xFF6C757D),
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    ClipOval(
                                      child: Image.network(
                                        jobDetail['contribution']['user']
                                            ['photo'],
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      jobDetail['contribution']['user']
                                          ['username'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Bricolage-R',
                                        //color: Color(0xFF6C757D),
                                      ),
                                    )
                                  ],
                                ),
                          const SizedBox(
                            width: double.infinity,
                            child: Divider(),
                          ),
                          Row(
                            children: [
                              languageProvider.lan == 'English'
                                  ? const Text(
                                      'Interested by',
                                      style: TextStyle(
                                        //color: Color(0xFF6C757D),
                                        fontFamily: 'Walone-B',
                                        fontSize: 13,
                                      ),
                                    )
                                  : const Text(
                                      'သင့်လို ယခုအလုပ်ကိုစိတ်ဝင်စားသူများ',
                                      style: TextStyle(
                                       // color: Color(0xFF6C757D),
                                        fontFamily: 'Walone-B',
                                        fontSize: 10,
                                      ),
                                    ),
                            ],
                          ),
                          if (interestedUser.isNotEmpty)
                            SizedBox(
                              height: 24,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    left: 0,
                                    child: CircleAvatar(
                                      radius: 10,
                                      child: ClipOval(
                                        child: Image.network(
                                          '${interestedUser[0]['photo']}',
                                          width: 24,
                                          height: 24,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // const Positioned(
                                  //   left: 12,
                                  //   child: Image(
                                  //     image: AssetImage('images/avatar2.png'),
                                  //     width: 24,
                                  //     height: 24,
                                  //   ),
                                  // ),
                                  if (interestedUser.length > 1)
                                    Positioned(
                                      left: 12,
                                      child: CircleAvatar(
                                        radius: 10,
                                        child: ClipOval(
                                          child: Image.network(
                                            '${interestedUser[1]['photo']}',
                                            width: 24,
                                            height: 24,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  // const Positioned(
                                  //   left: 24,
                                  //   child: Image(
                                  //     image: AssetImage('images/avatar3.png'),
                                  //     width: 24,
                                  //     height: 24,
                                  //   ),
                                  // ),
                                  if (interestedUser.length > 2)
                                    Positioned(
                                      left: 24,
                                      child: CircleAvatar(
                                        radius: 10,
                                        child: ClipOval(
                                          child: Image.network(
                                            '${interestedUser[2]['photo']}',
                                            width: 24,
                                            height: 24,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  // const Positioned(
                                  //   left: 36,
                                  //   child: Image(
                                  //     image: AssetImage('images/avatar4.png'),
                                  //     width: 24,
                                  //     height: 24,
                                  //   ),
                                  // ),
                                  if (interestedUser.length > 3)
                                    Positioned(
                                      left: 36,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.white,
                                        radius: 10,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          '+${interestedUser.length - 3}',
                                          style: const TextStyle(
                                            fontFamily: 'Bricolage-M',
                                            fontSize: 10,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
      persistentFooterButtons: [
        SizedBox(
          width: double.infinity,
          height: 42,
          child: TextButton(
            onPressed: widget.isClosed
                ? null
                : () {
                    showDialog(
                        context: context,
                        builder: (context) => TAndCDialog(jobId: widget.jobId));
                  },
            style: TextButton.styleFrom(
              backgroundColor: widget.isClosed
                  ? const Color(0x50FF3997)
                  : const Color(0xffFF3997),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Set the border radius
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                languageProvider.lan == 'English'
                    ? const Text(
                        'Apply Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Bricolage-B',
                          fontSize: 15.63,
                        ),
                      )
                    : const Text(
                        'လျှောက်ထားရန်',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Walone-B',
                          fontSize: 14,
                        ),
                      ),
                const SizedBox(
                  width: 15,
                ),
                const Icon(
                  CupertinoIcons.arrow_right,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        // SizedBox(
        //   width: 40,
        //   height: 42,
        //   child: TextButton(
        //     style: TextButton.styleFrom(
        //       backgroundColor: Colors.white,
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(8),
        //           side: const BorderSide(
        //             color: Color.fromARGB(255, 230, 233, 235),
        //             width: 1.5,
        //           )),
        //     ),
        //     onPressed: () {
        //       showDialog(
        //           context: context,
        //           builder: (context) => TAndCDialog(jobId: widget.jobId));
        //     },
        //     child: const Image(
        //       image: AssetImage('images/share_icon.png'),
        //       width: 24,
        //       height: 24,
        //     ),
        //   ),
        // )
      ],
    );
  }
}
