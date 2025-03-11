import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_textformfield.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/qr.dart';
import 'package:sabai_app/screens/auth_pages/api_service.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/services/payment_provider.dart';

class Payment extends StatefulWidget {
  late int? plan;

  Payment({
    required this.plan,
    super.key,
  });

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late int? selectedPlan;

  void fetchUserData() async {
    final paymentProvider =
        Provider.of<PaymentProvider>(context, listen: false);
    await paymentProvider.getProfileData();
  }

  @override
  void initState() {
    super.initState();
    fetchReviews();
    fetchUserData();
    selectedPlan = widget.plan; // Initialize with the widget's plan
  }

  final _formKey = GlobalKey<FormState>();

  // final _fullNameController = TextEditingController();
  //
  // final _phoneNumberController = TextEditingController();

  final _rCodeController = TextEditingController();

  final _pageController = PageController();

  late bool isPrompt = false;
  late bool isKBZ = false;

  late Color color = Colors.transparent;

  //fetching reviews
  List<dynamic> reviews = [];
  Future<void> fetchReviews() async {
    try {
      final response = await ApiService.get('/sales/reviews/');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        setState(() {
          reviews = data;
        });
      } else {
        print('error response code is not 200 ${response.body}');
      }
    } catch (e) {
      print('Error fetching $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var paymentProvider = Provider.of<PaymentProvider>(context);

    if (paymentProvider.userData == null) {
      return const Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: CircularProgressIndicator(
            color: primaryPinkColor,
          ),
        ),
      ); // Show loading state
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Upgrade to premium',
          style: appBarTitleStyleEng,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: backgroundColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
        ),
        iconTheme: const IconThemeData(
          color: primaryPinkColor,
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Full Name',
                  style: labelStyleEng,
                ),
                const SizedBox(
                  height: 8,
                ),
                // ReusableTextformfield(
                //   textEditingController: _fullNameController,
                //   validating: (value) {
                //     if (value == null || value.isEmpty) {
                //       return languageProvider.lan == 'English'
                //           ? "Full Name is required"
                //           : "အမည်အပြည့်အစုံထည့်ရန်လိုအပ်သည်";
                //     }
                //     return null;
                //   },
                //   hint: languageProvider.lan == 'English'
                //       ? 'Enter your full name'
                //       : 'သင့်အမည် ထည့်ပါ',
                // ),
                Container(
                  width: double.infinity,
                  height: 35,
                  padding: const EdgeInsets.only(
                    top: 6,
                    left: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${paymentProvider.userData!['username']}',
                    style: const TextStyle(
                      fontFamily: 'Bricolage-M',
                      color: Color(0xff616971),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Phone Number',
                  style: labelStyleEng,
                ),
                const SizedBox(
                  height: 8,
                ),
                // ReusableTextformfield(
                //   formatter: [FilteringTextInputFormatter.digitsOnly],
                //   textEditingController: _phoneNumberController,
                //   keyboardType: TextInputType.phone,
                //   validating: (value) {
                //     if (value == null || value.isEmpty) {
                //       return languageProvider.lan == 'English'
                //           ? "Phone Number is required"
                //           : "ဖုန်းနံပါတ်ထည့်ရန်လိုအပ်သည်";
                //     }
                //     return null;
                //   },
                //   hint: '+66 2134567',
                // ),
                // const Text(
                //   'Chosen Package',
                //   style: labelStyleEng,
                // ),
                Container(
                  width: double.infinity,
                  height: 35,
                  padding: const EdgeInsets.only(
                    top: 6,
                    left: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${paymentProvider.userData!['phone']}',
                    style: const TextStyle(
                      fontFamily: 'Bricolage-M',
                      color: Color(0xff616971),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPlan = 0;
                        widget.plan = 0;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 69,
                      decoration: widget.plan == 0
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              border: Border.all(
                                color: primaryPinkColor,
                                width: 2,
                              ),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    text: '250',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Bricolage-SMB',
                                        color: Color(0xff363B3F)),
                                    children: [
                                      TextSpan(
                                        text: ' THB',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Bricolage-R',
                                          color: Color(0xff616971),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (widget.plan == 0)
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffFFEBF6),
                                    ),
                                    child: const Icon(
                                      Icons.check_circle_outline,
                                      color: primaryPinkColor,
                                    ),
                                  )
                              ],
                            ),
                            const Text(
                              '1 month',
                              style: TextStyle(
                                fontFamily: 'Bricolage-R',
                                fontSize: 12.5,
                                color: Color(0xffB6BABE),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPlan = 2;
                        widget.plan = 2;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 69,
                      decoration: widget.plan == 2
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              border: Border.all(
                                color: primaryPinkColor,
                                width: 2,
                              ),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    text: '500',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Bricolage-SMB',
                                        color: Color(0xff363B3F)),
                                    children: [
                                      TextSpan(
                                        text: ' THB',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Bricolage-R',
                                          color: Color(0xff616971),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (widget.plan == 2)
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffFFEBF6),
                                    ),
                                    child: const Icon(
                                      Icons.check_circle_outline,
                                      color: primaryPinkColor,
                                    ),
                                  )
                              ],
                            ),
                            const Text(
                              '3 months',
                              style: TextStyle(
                                fontFamily: 'Bricolage-R',
                                fontSize: 12.5,
                                color: Color(0xffB6BABE),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Preferred payment method',
                  style: labelStyleEng,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isKBZ = false;
                        isPrompt = !isPrompt;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 44,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isPrompt == false ? color : primaryPinkColor,
                            width: 2,
                          )),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Prompt Pay',
                          style: TextStyle(
                            fontFamily: 'Bricolage-M',
                            fontSize: 14,
                            color: Color(0xff363B3F),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPrompt = false;
                        isKBZ = !isKBZ;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 44,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isKBZ == false ? color : primaryPinkColor,
                          width: 2,
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          'KBZ Pay',
                          style: TextStyle(
                            fontFamily: 'Bricolage-M',
                            fontSize: 14,
                            color: Color(0xff363B3F),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Redeem Code',
                  style: labelStyleEng,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ReusableTextformfield(
                    textEditingController: _rCodeController,
                    validating: (value) {
                      return null;
                    },
                    hint: 'Enter Redeem Code here',
                  ),
                ),
                const Text(
                  'Don’t take our word for it, Here’s what other job hunters are saying :',
                  style: labelStyleEng,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 200,
                    // child: PageView(
                    //   controller: _pageController,
                    //   children: const [
                    //     ReviewCard(),
                    //     ReviewCard(),
                    //     ReviewCard(),
                    //   ],
                    // ),
                    child: PageView.builder(
                        controller: _pageController,
                        itemCount: reviews.length,
                        itemBuilder: (context, index) {
                          return ReviewCard(
                            review: reviews[index],
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Container(
          width: 375,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextButton(
            onPressed: () {
              setState(() {
                if (_formKey.currentState!.validate() &&
                    (isKBZ == true || isPrompt == true)) {
                  isKBZ == true
                      ? paymentProvider.setPaymentMethodId(1)
                      : paymentProvider.setPaymentMethodId(2);
                  widget.plan == 0
                      ? paymentProvider.setPricingPlanId(2)
                      : paymentProvider.setPricingPlanId(1);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Qr(
                        isKbz: isKBZ,
                        isPrompt: isPrompt,
                      ),
                    ),
                  );
                } else {
                  color = Colors.red;
                  // form validation failed
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: languageProvider.lan == 'English'
                          ? const Text(
                              "Please completed all the required fields")
                          : const Text(
                              "လိုအပ်သောအကွက်များအားလုံးကို ဖြည့်စွက်ပါ။")));
                }
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xffFF3997),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Set the border radius
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                languageProvider.lan == 'English'
                    ? const Text(
                        'Continue',
                        style: TextStyle(
                          fontFamily: 'Bricolage-B',
                          fontSize: 15.63,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'ဆက်လက်ရန်',
                        style: TextStyle(
                          fontFamily: 'Walone-B',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  CupertinoIcons.arrow_right,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        )
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    this.review,
  });

  final dynamic review;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'images/quotation.png',
              width: 10,
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                review['text'],
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Bricolage-M',
                  color: Color(0xff363B3F),
                ),
              ),
            ),
            Row(
              children: [
                Image.asset(
                  'images/avatar1.png',
                  width: 25,
                  height: 25,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  review['user_username'],
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontFamily: 'Bricolage-R',
                    color: Color(0xff363B3F),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
