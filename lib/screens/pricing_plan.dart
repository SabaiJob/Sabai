import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sabai_app/screens/payment.dart';
import 'package:sabai_app/screens/auth_pages/api_service.dart';
import 'package:sabai_app/services/payment_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PricingPlan extends StatefulWidget {
  const PricingPlan({super.key});

  @override
  State<PricingPlan> createState() => _PricingPlanState();
}

class _PricingPlanState extends State<PricingPlan> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 2; // Default to show the second container in the center.

  // final List<Map<String, dynamic>> priceDetail = [
  //   {
  //     'price': '500',
  //     'text1': '20 job post a day',
  //     'text2': 'Verified jobs',
  //     'text3': '10 roses a day',
  //     'text4': 'Early access to new jobs',
  //     'plan': '3 months',
  //     'current': '',
  //   },
  //   {
  //     'price': '250',
  //     'text1': '20 job post a day',
  //     'text2': 'Verified jobs',
  //     'text3': '10 roses a day',
  //     'text4': 'Early access to new jobs',
  //     'plan': '1 month',
  //     'current': '',
  //   },
  //   {
  //     'price': 'Free',
  //     'text1': '20 job post a day',
  //     'text2': 'Verified jobs',
  //     'text3': '10 roses a day',
  //     'text4': 'Early access to new jobs',
  //     'plan': '',
  //     'current': 'active',
  //   },
  // ];
  List<Map<String, dynamic>> priceDetail = [];

  Future<void> getPricingPlan() async {
    try {
      final response = await ApiService.get('/sales/pricing/');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> data = json.decode(response.body);
        final List<Map<String, dynamic>> detail = data.map((job) {
          String price = job['price'];
          String plan = "${job['duration_in_months']} months";
          String text1 = job['checked_benefits'][0] ?? '';
          String text2 = job['checked_benefits'][1] ?? '';
          String text3 = job['checked_benefits'][2] ?? '';
          String text4 = job['checked_benefits'][3] ?? '';
          String text5 = job['checked_benefits'][4] ?? '';
          String current = '';
          String uncheck = job['unchecked_benefits'][0] ?? '';
          return {
            'price': price,
            'plan': plan,
            'text1': text1,
            'text2': text2,
            'text3': text3,
            'text4': text4,
            'text5': text5,
            'current': current,
            'uncheck': uncheck,
          };
        }).toList();
        setState(() {
          priceDetail = detail;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("error : ${response.body}"),
          ),
        );
        print('error ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching the data $e}'),
        ),
      );
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPricingPlan();
  }

  @override
  Widget build(BuildContext context) {
    var paymentProvider = Provider.of<PaymentProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        title: const Text(
          'Pricing plan',
          style: appBarTitleStyleEng,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xffFF3997),
        ),
        backgroundColor: const Color(0xffF7F7F7),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade300,
            height: 1.0,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Image.asset(
                'images/pricing.png',
                width: 120,
                height: 120,
              ),
            ),
            const Text(
              'Upgrade to Premium',
              style: TextStyle(
                fontSize: 24.41,
                fontFamily: 'Bricolage-SMB',
              ),
            ),
            const Text(
              'Browse as many jobs as you need \n without any limits!',
              style: TextStyle(
                fontSize: 15.63,
                fontFamily: 'Bricolage-R',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            SmoothPageIndicator(
              controller: PageController(initialPage: _currentIndex),
              count: priceDetail.length,
              effect: const WormEffect(
                dotHeight: 4,
                dotWidth: 4,
                activeDotColor: Colors.pink,
                dotColor: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: CarouselSlider(
                carouselController: _controller,
                items: priceDetail
                    .asMap()
                    .entries
                    .map(
                      (entry) => PricingContainer(
                        isSelected: _currentIndex == entry.key,
                        price: entry.value['price'],
                        text1: entry.value['text1'],
                        text2: entry.value['text2'],
                        text3: entry.value['text3'],
                        text4: entry.value['text4'],
                        text5: entry.value['text5'],
                        plan: entry.value['plan'],
                        current: entry.value['current'],
                        uncheckText: entry.value['uncheck'],
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 320,
                  initialPage: 2,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true, // Disables infinite scrolling.
                  viewportFraction: 0.55,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: GestureDetector(
                onTap: _currentIndex != 1
                    ? () {
                        _currentIndex == 2
                            ? paymentProvider.setPricingPlanId(1)
                            : paymentProvider.setPricingPlanId(2);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Payment(
                              plan: _currentIndex,
                            ),
                          ),
                        );
                        print(_currentIndex);
                      }
                    : null,
                child: Container(
                  height: 42,
                  width: 343,
                  decoration: BoxDecoration(
                    color: _currentIndex != 1
                        ? primaryPinkColor
                        : const Color(0x40FF3997),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Upgrade Now',
                      style: TextStyle(
                        fontFamily: 'Bricolage-B',
                        fontSize: 15.63,
                        color: Colors.white,
                      ),
                    ),
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

class PricingContainer extends StatelessWidget {
  const PricingContainer({
    required this.current,
    required this.isSelected,
    required this.price,
    required this.plan,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5,
    required this.uncheckText,
    super.key,
  });

  final bool isSelected;
  final String current;
  final String price;
  final String plan;
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;
  final String uncheckText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 214,
      height: 288,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected ? Colors.pink : Colors.transparent,
          width: 2.0,
        ),
        color: isSelected ? Colors.white : Colors.grey.shade200,
      ),
      child: Column(
        mainAxisAlignment: price == '250.00'
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (price == '250.00')
            Container(
              padding: const EdgeInsets.only(left: 7),
              width: 207,
              height: 37,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.transparent,
                    width: 3,
                  ),
                ),
                color: Color(0xffFFEBF6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Show the image only for '250' container.
                  Image.asset(
                    'images/status.png',
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                    child: Text(
                      'Boost job chances by 75%',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: primaryPinkColor,
                        fontFamily: 'Bricolage-M',
                      ),
                    ),
                  )
                ],
              ),
            ),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: price != '0.00' ? price : 'Free',
                    style: const TextStyle(
                        fontSize: 19.53,
                        fontFamily: 'Bricolage-SMB',
                        color: Colors.black),
                    children: [
                      price != '0.00'
                          ? const TextSpan(
                              text: ' THB',
                              style: TextStyle(
                                fontSize: 15.63,
                                fontFamily: 'Bricolage-R',
                                color: Color(0xff616971),
                              ),
                            )
                          : const TextSpan(text: ''),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                if (price != '0.00')
                  Text(
                    plan,
                    style: const TextStyle(
                      fontSize: 15.63,
                      fontFamily: 'Bricolage-R',
                      color: Color(0xff4C5258),
                    ),
                  ),
                if (current == 'active')
                  const Text(
                    'Current',
                    style: TextStyle(
                      fontSize: 15.63,
                      fontFamily: 'Bricolage-R',
                      color: Color(0xff28A745),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 15),
            child: Column(
              children: [
                if (text1.isNotEmpty)
                  PriceTexts(
                    text: text1,
                  ),
                if (text1.isNotEmpty)
                  const SizedBox(
                    height: 10,
                  ),
                if (text2.isNotEmpty)
                  PriceTexts(
                    text: text2,
                  ),
                if (text2.isNotEmpty)
                  const SizedBox(
                    height: 10,
                  ),
                if (text3.isNotEmpty)
                  PriceTexts(
                    text: text3,
                  ),
                if (text3.isNotEmpty)
                  const SizedBox(
                    height: 10,
                  ),
                if (text4.isNotEmpty)
                  PriceTexts(
                    text: text4,
                    // iconColor: price == 'Free'
                    //     ? const Color(0xffC4C8CB)
                    //     : primaryPinkColor,
                    // textColor: price == 'Free'
                    //     ? const Color(0xffC4C8CB)
                    //     : Colors.black,
                  ),
                if (text4.isNotEmpty)
                  const SizedBox(
                    height: 10,
                  ),
                if (text5.isNotEmpty)
                  PriceTexts(
                    text: text5,
                  ),
                if (text5.isNotEmpty)
                  const SizedBox(
                    height: 10,
                  ),
                if (uncheckText.isNotEmpty)
                  UncheckedText(
                    text: uncheckText,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PriceTexts extends StatelessWidget {
  const PriceTexts({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (text.isNotEmpty)
          const Icon(
            Icons.check,
            size: 16,
            color: primaryPinkColor,
          ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12.5,
            fontFamily: 'Bricolage-R',
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class UncheckedText extends StatelessWidget {
  const UncheckedText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (text.isNotEmpty)
          const Icon(
            Icons.check,
            size: 16,
            color: Color(0xffC4C8CB),
          ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12.5,
            fontFamily: 'Bricolage-R',
            color: Color(0xffC4C8CB),
          ),
        ),
      ],
    );
  }
}
