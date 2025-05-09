import 'package:flutter/material.dart';
import 'package:sabai_app/screens/spin_wheel.dart';
import 'package:sabai_app/services/payment_provider.dart';
import '../constants.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:provider/provider.dart';

class RoseCountPage extends StatefulWidget {
  const RoseCountPage({super.key});

  @override
  State<RoseCountPage> createState() => _RoseCountPageState();
}

class _RoseCountPageState extends State<RoseCountPage> {
  @override
  void initState() {
    super.initState();
    fetchRoseCount();
  }

  void fetchRoseCount() async {
    final paymentProvider =
        Provider.of<PaymentProvider>(context, listen: false);
    await paymentProvider.getRoseCount(context);
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var paymentProvider = Provider.of<PaymentProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFED7EA), // Background for the app
      appBar: AppBar(
        backgroundColor: const Color(0xFFFED7EA),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey.shade300,
              height: 1.0,
            )),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: languageProvider.lan == 'English'
            ? const Text(
                "Your roses",
                style: appBarTitleStyleEng,
              )
            : const Text(
                'ကျွန်တော့်နှင်းဆီပွင့်များ',
                style: appBarTitleStyleMn,
              ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xFFFF3997),
        ),
      ),
      body: Column(
        children: [
          // Curved Header Section
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFFED7EA),
                ),
              ),
              const Positioned(
                  top: 50, left: 0, right: 0, child: AnimatedRose()),
            ],
          ),

          //const SizedBox(height: 80), // Space below header

          // Roses Info and Recent Givers Section
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(290, 100),
                  topRight: Radius.elliptical(290, 100),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  languageProvider.lan == 'English'
                      ? RichText(
                          text: TextSpan(children: [
                            const TextSpan(
                                text: 'You ',
                                style: TextStyle(
                                  color: Color(0xFF4C5258),
                                  fontFamily: 'Bricolage-R',
                                  fontSize: 19.5,
                                )),
                            const TextSpan(
                                text: 'got ',
                                style: TextStyle(
                                  color: Color(0xFF4C5258),
                                  fontFamily: 'Bricolage-R',
                                  fontSize: 19.5,
                                )),
                            TextSpan(
                                text: paymentProvider.roseCount?['total_roses']
                                    .toString(),
                                style: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 19.5,
                                )),
                            const TextSpan(
                                text: ' roses!',
                                style: TextStyle(
                                  color: Color(0xFF4C5258),
                                  fontFamily: 'Bricolage-R',
                                  fontSize: 19.5,
                                )),
                          ]),
                        )
                      : RichText(
                          text: TextSpan(children: [
                            const TextSpan(
                                text: 'နှင်းဆီ ',
                                style: TextStyle(
                                  color: Color(0xFF4C5258),
                                  fontFamily: 'Walone-B',
                                  fontSize: 19.5,
                                )),
                            TextSpan(
                                text: paymentProvider.roseCount?['total_roses']
                                    .toString(),
                                style: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'Walone-B',
                                  fontSize: 19.5,
                                )),
                            const TextSpan(
                                text: ' ပွင့်ရခဲ့ပြီ!',
                                style: TextStyle(
                                  color: Color(0xFF4C5258),
                                  fontFamily: 'Walone-B',
                                  fontSize: 19.5,
                                )),
                          ]),
                        ),
                  const SizedBox(height: 10),
                  Text(
                    languageProvider.lan == 'English'
                        ? 'See who gave you roses.'
                        : 'ဘယ်သူတွေပေးတာလဲကြည့်မယ်',
                    style: languageProvider.lan == 'English'
                        ? const TextStyle(
                            color: Color(0xFF4C5258),
                            fontFamily: 'Bricolage-R',
                            fontSize: 12.5)
                        : const TextStyle(
                            color: Color(0xFF4C5258),
                            fontFamily: 'Walone-B',
                            fontSize: 11),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      languageProvider.lan == 'English'
                          ? 'Recent givers'
                          : 'လက်တလောပေးထားသူများ',
                      style: languageProvider.lan == 'English'
                          ? const TextStyle(
                              fontSize: 12.5,
                              fontFamily: 'Bricolage-R',
                              color: Color(0xFF6C757D))
                          : const TextStyle(
                              fontSize: 11,
                              fontFamily: 'Walone-B',
                              color: Color(0xFF6C757D)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (paymentProvider.roseCount!['rose_history'].isEmpty) ...[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Center(
                          child: languageProvider.lan == 'English'
                              ? const Text('No recent givers',
                                  style: TextStyle(
                                      fontFamily: 'Bricolage-R',
                                      fontSize: 15.63,
                                      color: Color(0xFF6C757D)))
                              : const Text('လတ်တလောပေးထားသူများမရှိပါ',
                                  style: TextStyle(
                                      fontFamily: 'Walone-B',
                                      fontSize: 15.63,
                                      color: Color(0xFF6C757D))),
                        ),
                      ),
                    )
                  ] else ...[
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return ListTile(
                              minVerticalPadding: 5,
                              minTileHeight: 10,
                              leading: ClipOval(
                                child: Image.network(
                                  paymentProvider.roseCount!['rose_history']
                                      [index]['photo'],
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                paymentProvider.roseCount!['rose_history']
                                    [index]['username'],
                                style: const TextStyle(
                                    fontFamily: 'Bricolage-R',
                                    fontSize: 15.63,
                                    color: Color(0xFF6C757D)),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(color: Color(0xFFF0F1F2));
                          },
                          itemCount: paymentProvider
                              .roseCount!['rose_history'].length),
                    )),
                  ],
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 42,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SpinWheel()));
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xffFF3997),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Set the border radius
                        ),
                      ),
                      child: languageProvider.lan == 'English'
                          ? const Text(
                              'Get Rewards',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Bricolage-B',
                                fontSize: 15.63,
                              ),
                            )
                          : const Text(
                              'ဆုများရယူမယ်',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Walone-B',
                                fontSize: 14,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedRose extends StatefulWidget {
  const AnimatedRose({super.key});

  @override
  State<AnimatedRose> createState() => _AnimatedRoseState();
}

class _AnimatedRoseState extends State<AnimatedRose>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _waveController1;
  late AnimationController _waveController2;
  late Animation<double> _floatAnimation;
  late Animation<double> _waveScaleAnimation1;
  late Animation<double> _waveOpacityAnimation1;
  late Animation<double> _waveScaleAnimation2;
  late Animation<double> _waveOpacityAnimation2;

  @override
  void initState() {
    super.initState(); // This should be the first line

    // Initialize controllers first
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _waveController1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _waveController2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Then set up animations using the controllers
    _floatAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _waveScaleAnimation1 = Tween<double>(begin: 1, end: 3).animate(
      CurvedAnimation(parent: _waveController1, curve: Curves.easeOut),
    );

    _waveOpacityAnimation1 = Tween<double>(begin: 0.5, end: 0).animate(
      CurvedAnimation(parent: _waveController1, curve: Curves.easeOut),
    );

    _waveScaleAnimation2 = Tween<double>(begin: 1, end: 3.5).animate(
      CurvedAnimation(parent: _waveController2, curve: Curves.easeOut),
    );

    _waveOpacityAnimation2 = Tween<double>(begin: 0.5, end: 0).animate(
      CurvedAnimation(parent: _waveController2, curve: Curves.easeOut),
    );

    // Start the animations after everything is set up
    _floatController.repeat(reverse: true);
    _waveController1.repeat();
    _waveController2.repeat(
        reverse: false, period: const Duration(milliseconds: 1500));
  }

  @override
  void dispose() {
    _floatController.dispose();
    _waveController1.dispose();
    _waveController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(
          [_floatController, _waveController1, _waveController2]),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // First ripple wave
            Transform.scale(
              scale: _waveScaleAnimation1.value,
              child: Opacity(
                opacity: _waveOpacityAnimation1.value,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.pinkAccent.withOpacity(0.3),
                  ),
                ),
              ),
            ),

            // Second ripple wave (Delayed)
            Transform.scale(
              scale: _waveScaleAnimation2.value,
              child: Opacity(
                opacity: _waveOpacityAnimation2.value,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.pinkAccent.withOpacity(0.2),
                  ),
                ),
              ),
            ),

            // Floating Rose
            Transform.translate(
              offset: Offset(0, -_floatAnimation.value),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFEBF6),
                  border: Border.all(color: const Color(0xFFFF3997), width: 5),
                ),
                child: Image.asset(
                  'icons/rose.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
