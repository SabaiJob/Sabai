import 'package:flutter/material.dart';
import 'package:sabai_app/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:io';

class PricingPlan extends StatefulWidget {
  const PricingPlan({super.key});

  @override
  State<PricingPlan> createState() => _PricingPlanState();
}

class _PricingPlanState extends State<PricingPlan> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 1; // Default to show the second container in the center.

  final List<Map<String, dynamic>> priceDetail = [
    {
      'price': '500',
      'text1': '20 job post a day',
      'text2': 'Verified jobs',
      'text3': '10 roses a day',
      'text4': 'Early access to new jobs',
      'plan': '3 months',
    },
    {
      'price': '250',
      'text1': '20 job post a day',
      'text2': 'Verified jobs',
      'text3': '10 roses a day',
      'text4': 'Early access to new jobs',
      'plan': '1 month',
    },
    {
      'price': 'Free',
      'text1': '20 job post a day',
      'text2': 'Verified jobs',
      'text3': '10 roses a day',
      'text4': 'Early access to new jobs',
      'plan': 'Current',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                        plan: entry.value['plan'],
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 288,
                  initialPage: 1,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false, // Disables infinite scrolling.
                  viewportFraction: Platform.isAndroid ? 0.5 : 0.6,
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
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                child: Container(
                  height: 42,
                  width: 343,
                  decoration: BoxDecoration(
                    color: primaryPinkColor,
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
    required this.isSelected,
    required this.price,
    required this.plan,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    super.key,
  });

  final bool isSelected;
  final String price;
  final String plan;
  final String text1;
  final String text2;
  final String text3;
  final String text4;

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
        mainAxisAlignment: price == '250'
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (price == '250')
            Container(
              padding: const EdgeInsets.only(left: 7),
              width: 199,
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
          Column(
            children: [
              RichText(
                text: TextSpan(
                  text: price,
                  style: const TextStyle(
                      fontSize: 19.53,
                      fontFamily: 'Bricolage-SMB',
                      color: Colors.black),
                  children: [
                    price != 'Free'
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
              Text(
                plan,
                style: const TextStyle(
                  fontSize: 15.63,
                  fontFamily: 'Bricolage-R',
                  color: Color(0xff4C5258),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 15),
            child: Column(
              children: [
                PriceTexts(
                  text: text1,
                  iconColor: primaryPinkColor,
                  textColor: Colors.black,
                ),
                const SizedBox(
                  height: 15,
                ),
                PriceTexts(
                  text: text2,
                  iconColor: primaryPinkColor,
                  textColor: Colors.black,
                ),
                const SizedBox(
                  height: 15,
                ),
                PriceTexts(
                  text: text3,
                  iconColor: primaryPinkColor,
                  textColor: Colors.black,
                ),
                const SizedBox(
                  height: 15,
                ),
                PriceTexts(
                  text: text4,
                  iconColor: price == 'Free'
                      ? const Color(0xffC4C8CB)
                      : primaryPinkColor,
                  textColor:
                      price == 'Free' ? const Color(0xffC4C8CB) : Colors.black,
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
    required this.iconColor,
    required this.textColor,
  });

  final String text;
  final Color iconColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.check,
          size: 16,
          color: iconColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 12.5,
            fontFamily: 'Bricolage-R',
            color: textColor,
          ),
        ),
      ],
    );
  }
}
