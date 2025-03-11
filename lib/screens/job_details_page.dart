import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_bulletpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:sabai_app/components/tc_dialog.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/auth_pages/api_service.dart';
import 'package:sabai_app/services/language_provider.dart';

class JobDetailsPage extends StatefulWidget {
  const JobDetailsPage({super.key, required this.jobId});
  final int jobId;

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
          //print(interestedUser[0]);
        });
      } else {
        print('Fetching error: ${response.body}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchJobDetail();
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
                        fontSize: 19.53,
                        fontFamily: 'Bricolage-M',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        width: 343,
                        height: 228,
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
                                    width: 116,
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
                                          image:
                                              AssetImage('images/status.png'),
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
                                                    fontSize: 10,
                                                    color: Color(0xFF6C757D)),
                                              )
                                            : RichText(
                                                text: const TextSpan(
                                                  text: 'Sabai Job  ',
                                                  style: TextStyle(
                                                    fontFamily: 'Bricolage-R',
                                                    fontSize: 10,
                                                    color: Color(0xFF6C757D),
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: 'မိတ်ဖက်',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontFamily: 'Walone-B',
                                                        color:
                                                            Color(0xFF6C757D),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Offered by',
                                        style: TextStyle(
                                          color: Color(0xFF6C757D),
                                          fontFamily: 'Bricolage-R',
                                          fontSize: 10,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${jobDetail['company_name']}',
                                        style: const TextStyle(
                                          color: Color(0xFF4C5258),
                                          fontFamily: 'Bricolage-M',
                                          fontSize: 12.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      languageProvider.lan == 'English'
                                          ? const Text(
                                              'Salary',
                                              style: TextStyle(
                                                color: Color(0xFF6C757D),
                                                fontFamily: 'Bricolage-R',
                                                fontSize: 10,
                                              ),
                                            )
                                          : const Text(
                                              'လစာ',
                                              style: TextStyle(
                                                fontFamily: 'Walone-R',
                                                fontSize: 10,
                                                color: Color(0xff6C757D),
                                              ),
                                            ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      languageProvider.lan == 'English'
                                          ? Text(
                                              '${jobDetail['salary_min']} ~ ${jobDetail['salary_max']} ${jobDetail['currency']}',
                                              style: const TextStyle(
                                                color: Color(0xFF4C5258),
                                                fontFamily: 'Bricolage-M',
                                                fontSize: 12.5,
                                              ),
                                            )
                                          : const Text(
                                              '၁၈၀၀၀ ~ ၂၈၀၀၀ ဘတ်',
                                              style: TextStyle(
                                                fontFamily: 'Walone-B',
                                                fontSize: 11,
                                                color: Color(0xff4C5258),
                                              ),
                                            ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      languageProvider.lan == 'English'
                                          ? const Text(
                                              'Safety',
                                              style: TextStyle(
                                                color: Color(0xFF6C757D),
                                                fontFamily: 'Bricolage-R',
                                                fontSize: 10,
                                              ),
                                            )
                                          : const Text(
                                              'စိတ်ချရမှု',
                                              style: TextStyle(
                                                fontFamily: 'Walone-R',
                                                fontSize: 10,
                                                color: Color(0xff6C757D),
                                              ),
                                            ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFEAF6EC),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                        ),
                                        width: 65,
                                        height: 21,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.info_outline,
                                              size: 13,
                                              color: Color(0xFF28A745),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            languageProvider.lan == 'English'
                                                ? Text(
                                                    'Level - ${jobDetail['safety_level']}',
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  )
                                                : const Text(
                                                    'အဆင့် - ၃',
                                                    style: TextStyle(
                                                      fontFamily: 'Walone-B',
                                                      fontSize: 10,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      languageProvider.lan == 'English'
                                          ? const Text(
                                              'Location',
                                              style: TextStyle(
                                                color: Color(0xFF6C757D),
                                                fontFamily: 'Bricolage-R',
                                                fontSize: 10,
                                              ),
                                            )
                                          : const Text(
                                              'တည်နေရာ',
                                              style: TextStyle(
                                                fontFamily: 'Walone-R',
                                                fontSize: 10,
                                                color: Color(0xff6C757D),
                                              ),
                                            ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text('${jobDetail['location']}',
                                          style: const TextStyle(
                                            color: Color(0xFF4C5258),
                                            fontFamily: 'Bricolage-M',
                                            fontSize: 12.5,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
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
                              fontFamily: 'Bricolage-M',
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
                    languageProvider.lan == 'English'
                        ? Text(
                            '${jobDetail['job_summary']}',
                            style: const TextStyle(
                              fontFamily: 'Bricolage-R',
                              color: Color(0xFF4C5258),
                              fontSize: 12.5,
                            ),
                          )
                        : const Text(
                            'ဘရစ်စတာသည် ကော်ဖီနှင့် လက်ဖက်ရည်အမျိုးမျိုးကို ပြင်ဆင်၍ ဝယ်ယူသူများအား ဝန်ဆောင်မှုအရည်အသွေးမြင့်မားမှုကို အာမခံပေးပြီး၊ အလုပ်ခွင်ကို သန့်ရှင်းပြီး စီမံခန့်ခွဲထားသောနေရာတစ်ခုအဖြစ် ထိန်းသိမ်းရမည်။',
                            style: TextStyle(
                              fontFamily: 'Walone-B',
                              color: Color(0xFF4C5258),
                              fontSize: 11,
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
                              fontFamily: 'Bricolage-M',
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
                              fontFamily: 'Bricolage-M',
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
                          vertical: 15, horizontal: 15),
                      width: 343,
                      height: 142,
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
                                        color: Color(0xFF6C757D),
                                        fontFamily: 'Bricolage-R',
                                        fontSize: 10,
                                      ),
                                    )
                                  : const Text(
                                      'အလုပ်တင်ပေးသူ',
                                      style: TextStyle(
                                        color: Color(0xFF6C757D),
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
                                width: languageProvider.lan == 'English'
                                    ? 78
                                    : 100,
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
                                              fontFamily: 'Bricolage-R',
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
                          const Row(
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
                                  fontSize: 12.5,
                                  fontFamily: 'Bricolage-R',
                                  color: Color(0xFF6C757D),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 311,
                            child: Divider(),
                          ),
                          Row(
                            children: [
                              languageProvider.lan == 'English'
                                  ? const Text(
                                      'Interested by',
                                      style: TextStyle(
                                        color: Color(0xFF6C757D),
                                        fontFamily: 'Bricolage-R',
                                        fontSize: 10,
                                      ),
                                    )
                                  : const Text(
                                      'သင့်လို ယခုအလုပ်ကိုစိတ်ဝင်စားသူများ',
                                      style: TextStyle(
                                        color: Color(0xFF6C757D),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 287,
              height: 42,
              child: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => const TAndCDialog());
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffFF3997),
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
              ),
            ),
            SizedBox(
              width: 40,
              height: 42,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 230, 233, 235),
                        width: 1.5,
                      )),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => const TAndCDialog());
                },
                child: const Image(
                  image: AssetImage('images/share_icon.png'),
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
