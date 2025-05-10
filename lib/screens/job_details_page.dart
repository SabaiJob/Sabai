import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/cv_upload_model.dart';
import 'package:sabai_app/components/reusable_bulletpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:sabai_app/components/tc_dialog.dart';
import 'package:sabai_app/components/work_card.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/auth_pages/api_service.dart';
import 'package:sabai_app/services/general_service.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/services/payment_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetailsPage extends StatefulWidget {
  const JobDetailsPage(
      {super.key, required this.jobId, required this.isClosed});
  final int jobId;
  final bool isClosed;

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  Map<String, dynamic> jobDetail = {};
  List<dynamic> interestedUser = [];
  String? externalLink;
  bool isLoading = true;
  int? jobId;
  int? receiverId;
  bool? gaveRose;
  Map<String, dynamic>? contribution;

  Future<void> fetchJobDetail() async {
    try {
      final response = await ApiService.get('/jobs/${widget.jobId}/');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> data =
            json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          jobDetail = data['job'];
          interestedUser = data['job']['interested_by']['users'];
          isLoading = false;
          externalLink = jobDetail['link'];
          jobId = jobDetail['id'];
          gaveRose = jobDetail['has_given_rose'];
          if (jobDetail['contribution'] != null) {
            contribution = jobDetail['contribution'];
            receiverId = jobDetail['contribution']['user']['id'];
          } else {
            contribution = null;
            receiverId = null;
          }
          // if (jobDetail['is_partner'] == false) {
          //   externalLink = jobDetail['link'];
          // } else {
          //   externalLink = '';
          // }
          print('jobDetail: $jobDetail');
          print('job_id: $jobId');
          print('receiver_id: $receiverId');
          print('contribution: $contribution');
          print('external link: $externalLink');
          print('has_given_rose: $gaveRose');
          // print(jobDetail['category']);
        });
      } else {
        print('Fetching error: ${response.body}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> openLink() async {
    try {
      final uri = Uri.parse(Uri.encodeFull(externalLink!));
      print("Uri: $uri");
      bool launched =
          await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) {
        print('Could not launch $externalLink');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.white,
            content: Text('The link has expired.',
                style: TextStyle(
                    fontFamily: 'Bricolage-M',
                    fontSize: 12.5,
                    color: Color(0xFF616971)))));
      }
    } catch (e) {
      print('Error launching $externalLink: $e');
    }
  }

  List<dynamic> _jobCategories = [];
  Future<void> fetchCategory() async {
    try {
      final response = await ApiService.get('/jobs/categories/');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        setState(() {
          _jobCategories = json.decode(response.body);
          //print(_jobCategories);
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
      if (category['id'] == id) {
        return category['name'];
      }
    }

    // Return a default value if no matching category is found
    return "Unknown Category";
  }

  Future<void> sendRose(LanguageProvider languageProvider) async {
    try {
      final response = await ApiService.post(
          '/rewards/give-rose/', {'receiver_id': receiverId, 'job_id': jobId});
      if (response.statusCode >= 200 && response.statusCode < 300) {
        setState(() {
          gaveRose = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 3,
            backgroundColor: Colors.white,
            content: Row(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: primaryPinkColor,
                  size: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  languageProvider.lan == 'English'
                      ? 'Thanks sent with a rose!'
                      : 'ကျေးဇူးတင်ပြီးပါပြီ!',
                  style: const TextStyle(
                    fontFamily: 'Bricolage-M',
                    fontSize: 12.5,
                    color: Color(0xFF616971),
                  ),
                ),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          elevation: 3,
          backgroundColor: Colors.white,
          content: Text('Failed to send rose. Error ${response.statusCode}',
              style: const TextStyle(
                fontFamily: 'Bricolage-M',
                fontSize: 12.5,
                color: Color(0xFF616971),
              )),
          behavior: SnackBarBehavior.floating,
        ));
      }
    } catch (e) {
      print('Catch Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 3,
        backgroundColor: Colors.white,
        content: Text('You can not send rose at the moment!',
            style: const TextStyle(
              fontFamily: 'Bricolage-M',
              fontSize: 12.5,
              color: Color(0xFF616971),
            )),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    //fetchUserData();
    fetchJobDetail();
    fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var paymentProvider = Provider.of<PaymentProvider>(context);
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
                      constraints: const BoxConstraints(
                        minHeight: 400, // Minimum height
                      ),
                      //height: 400,
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
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxHeight:
                                        60, // Maximum height for company section
                                  ),
                                ),
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
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
                                    jobDetail['is_salary_negotiable']
                                        ? languageProvider.lan == 'English'
                                            ? const Text(
                                                'Negotiable',
                                                style: TextStyle(
                                                  // color: Color(0xFF4C5258),
                                                  fontFamily: 'Walone-B',
                                                  fontSize: 15.63,
                                                ),
                                              )
                                            : const Text(
                                                'ညှိနှိုင်း',
                                                style: TextStyle(
                                                  fontFamily: 'Walone-B',
                                                  fontSize: 15.63,
                                                  // color: Color(0xff4C5258),
                                                ),
                                              )
                                        : Text(
                                            '${jobDetail['salary_min']} ~ ${jobDetail['salary_max']} ${jobDetail['currency']}',
                                            style: const TextStyle(
                                              // color: Color(0xFF4C5258),
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
                                        level: jobDetail['safety_level'] ?? '0',
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
                                          jobDetail['category'] ?? -1),
                                      style: const TextStyle(
                                        //color: Color(0xFF4C5258),
                                        color: Colors.black,
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
                                        color: Colors.black,
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
                      itemCount: jobDetail['key_responsibilities'].length ?? 0,
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
                      itemCount: jobDetail['qualifications'].length ?? 0,
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
                              if (jobDetail['contribution'] != null &&
                                  paymentProvider.userData!['user_id'] !=
                                      jobDetail['contribution']['user']
                                          ['id']) ...[
                                gaveRose == true
                                    ? GestureDetector(
                                        onTap: null,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFFE2E3E5),
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(4)),
                                          ),
                                          width: 120,
                                          height: 25,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const Image(
                                                image: AssetImage(
                                                    'images/rose.png'),
                                                width: 12,
                                                height: 15.26,
                                              ),
                                              languageProvider.lan == 'English'
                                                  ? const Text(
                                                      'You\'ve said Thanks',
                                                      style: TextStyle(
                                                        fontFamily: 'Walone-B',
                                                        fontSize: 10,
                                                        color:
                                                            Color(0xFFFF4DA1),
                                                      ),
                                                    )
                                                  : const Text(
                                                      'ကျေးဇူးတင်ပြီးပါပြီ',
                                                      style: TextStyle(
                                                        fontFamily: 'Walone-B',
                                                        fontSize: 10,
                                                        color:
                                                            Color(0xFFFF4DA1),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          sendRose(languageProvider);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFFE2E3E5),
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(4)),
                                          ),
                                          width: 100,
                                          height: 25,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const Image(
                                                image: AssetImage(
                                                    'images/rose.png'),
                                                width: 12,
                                                height: 15.26,
                                              ),
                                              languageProvider.lan == 'English'
                                                  ? const Text(
                                                      'Say Thanks',
                                                      style: TextStyle(
                                                        fontFamily: 'Walone-B',
                                                        fontSize: 10,
                                                        color:
                                                            Color(0xFFFF4DA1),
                                                      ),
                                                    )
                                                  : const Text(
                                                      'ကျေးဇူးတင်ပါသည် ',
                                                      style: TextStyle(
                                                        fontFamily: 'Walone-B',
                                                        fontSize: 10,
                                                        color:
                                                            Color(0xFFFF4DA1),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ),
                                      )
                              ],
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
          child: jobDetail['is_partner'] == true
              ? TextButton(
                  onPressed: widget.isClosed
                      ? null
                      // org method with cv upload
                      // : () async {
                      //     bool isAccepted =
                      //         await GeneralService.getForApplyButton();
                      //     if (isAccepted) {
                      //       showDialog(
                      //           context: context,
                      //           builder: (context) => CvUploadModel(
                      //                 jobId: widget.jobId,
                      //               ),
                      //           barrierDismissible: false);
                      //     } else {
                      // showDialog(
                      //     context: context,
                      //     builder: (context) =>
                      //         TAndCDialog(jobId: widget.jobId));
                      // }
                      //   },
                      : () async {
                          bool isAccepted =
                              await GeneralService.getForApplyButton();
                          // first time job applyer
                          if (!isAccepted) {
                            // show T&C
                            showDialog(
                                context: context,
                                builder: (context) => TAndCDialog(
                                      jobId: widget.jobId,
                                      onPressed: () async {
                                        await GeneralService.saveForApplyButton(
                                            true);
                                        Navigator.pop(context);
                                        openLink();
                                      },
                                    ));
                          } else {
                            // open external browser
                            openLink();
                          }
                        },
                  style: TextButton.styleFrom(
                    backgroundColor: widget.isClosed
                        ? const Color(0x50FF3997)
                        : const Color(0xffFF3997),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Set the border radius
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
                )
              : TextButton(
                  onPressed: widget.isClosed
                      ? null
                      //original method
                      // : () {
                      //     print(
                      //         'Go to external browser to see the original job post.');
                      //     openLink();
                      //   },
                      : () async {
                          bool isAccepted =
                              await GeneralService.getForApplyButton();
                          // first time job applyer
                          if (!isAccepted) {
                            // show T&C
                            showDialog(
                                context: context,
                                builder: (context) => TAndCDialog(
                                      jobId: widget.jobId,
                                      onPressed: () async {
                                        await GeneralService.saveForApplyButton(
                                            true);
                                        Navigator.pop(context);
                                        openLink();
                                      },
                                    ));
                          } else {
                            // open external browser
                            openLink();
                          }
                        },
                  style: TextButton.styleFrom(
                    backgroundColor: widget.isClosed
                        ? const Color(0x50FF3997)
                        : const Color(0xffFF3997),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Set the border radius
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      languageProvider.lan == 'English'
                          ? const Text(
                              'See Original Post',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Bricolage-B',
                                fontSize: 15.63,
                              ),
                            )
                          : const Text(
                              'မူလ အလုပ်ခေါ်စာ ကိုကြည့်ရန်',
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
