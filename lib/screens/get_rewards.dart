import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/earn_roses_page.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';
import 'package:sabai_app/screens/redeem_rewards_page.dart';
import 'package:sabai_app/screens/rose_count_page.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/services/payment_provider.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  @override
  void initState() {
    super.initState();
    fetchRoseCount();
    fetchUserReward();
  }

  void fetchRoseCount() async {
    final paymentProvider =
        Provider.of<PaymentProvider>(context, listen: false);
    await paymentProvider.getRoseCount(context);
    if (paymentProvider.userRewards != null) {
      paymentProvider.separateRewardsByStatus();
    }
  }

  void fetchUserReward() async {
    final paymentProvider =
        Provider.of<PaymentProvider>(context, listen: false);
    await paymentProvider.getUserRewards(context);
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var paymentProvider = Provider.of<PaymentProvider>(context);
    if (paymentProvider.roseCount == null ||
        paymentProvider.userRewards == null) {
      return const Scaffold(
        backgroundColor: Color(0xFFF7F7F7),
        body: Center(
          child: CircularProgressIndicator(
            color: primaryPinkColor,
          ),
        ),
      );
    }
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NavigationHomepage()));
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: primaryPinkColor,
            ),
          ),
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
                  "My Rewards",
                  style: appBarTitleStyleEng,
                )
              : const Text(
                  'ကျွန်တော့်ဆုများ',
                  style: appBarTitleStyleMn,
                ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color(0xFFFF3997),
          ),
        ),
        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFED7EA),
                  ),
                ),
                const Positioned(
                    top: 20, left: 0, right: 0, child: AnimatedBox()),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Colors.white,
              ),
              width: 343,
              height: 85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      languageProvider.lan == 'English'
                          ? RichText(
                              text: TextSpan(children: [
                                const TextSpan(
                                    text: 'You ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Bricolage-SMB',
                                      fontSize: 15.6,
                                    )),
                                const TextSpan(
                                    text: 'got ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Bricolage-SMB',
                                      fontSize: 15.6,
                                    )),
                                TextSpan(
                                    text: paymentProvider
                                        .roseCount?['total_roses']
                                        .toString(),
                                    style: const TextStyle(
                                      color: Color(0xFF000000),
                                      fontFamily: 'Bricolage-M',
                                      fontSize: 19.5,
                                    )),
                                const TextSpan(
                                    text: ' roses!',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Bricolage-SMB',
                                      fontSize: 15.6,
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
                                    text: paymentProvider
                                        .roseCount?['total_roses']
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
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RoseCountPage())),
                        child: const Icon(
                          Icons.arrow_forward_sharp,
                          color: primaryPinkColor,
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EarnRosesPage())),
                    child: languageProvider.lan == 'English'
                        ? const Text(
                            'How to earn roses ?',
                            style: TextStyle(
                                fontFamily: 'Walone - B',
                                fontSize: 11,
                                color: Color(0xFF2B2F32),
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFF2B2F32),
                                decorationStyle: TextDecorationStyle.solid),
                          )
                        : const Text('နှင်းဆီပွင့်ဘယ်လိုရယူကြမလဲ?',
                            style: TextStyle(
                                fontFamily: 'Walone - R',
                                fontSize: 12.5,
                                color: Color(0xFF4C5258),
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFF2B2F32),
                                decorationStyle: TextDecorationStyle.solid)),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 33,
                decoration: BoxDecoration(
                  color:
                      const Color(0xFFF0F1F2), // Background color for tab bar
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TabBar(
                  tabAlignment: TabAlignment.fill,
                  automaticIndicatorColorAdjustment: true,
                  isScrollable: false,
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelColor: Colors.pink,
                  unselectedLabelColor: Colors.pink.shade300,
                  dividerColor: Colors.transparent,
                  labelStyle: const TextStyle(
                      fontSize: 12.5,
                      color: Color(0xffFF3997),
                      fontFamily: 'Bricolage-R'),
                  tabs: [
                    Tab(
                      text: languageProvider.lan == 'English'
                          ? 'Available'
                          : 'ရနိုင်သော',
                    ),
                    Tab(
                      text: languageProvider.lan == 'English'
                          ? 'Expired'
                          : 'သက်တမ်းကုန်သွာသော',
                    ),
                    Tab(
                      text: languageProvider.lan == 'English'
                          ? 'Redeemed'
                          : 'ရရှိပြီးသော',
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 332,
              child: TabBarView(children: [
                Center(
                  child: AvailableRewards(
                    availableRewards:
                        paymentProvider.separatedRewards['available'] ?? [],
                  ),
                ),
                Center(
                  child: ExpiredRewards(
                      expiredRewards:
                          paymentProvider.separatedRewards['expired'] ?? []),
                ),
                Center(
                  child: RedeemedRewards(
                      redeemedRewards:
                          paymentProvider.separatedRewards['redeemed'] ?? []),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class AvailableRewards extends StatelessWidget {
  final List<dynamic> availableRewards;
  const AvailableRewards({super.key, required this.availableRewards});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    if (availableRewards.isEmpty) {
      return const Center(
        child: Text(
          'No rewards yet',
          style: TextStyle(
              fontFamily: 'Bricolage-B',
              fontSize: 11,
              color: Color(0xFF2B2F32)),
        ),
      );
    }
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              leading: Material(
                color: Colors.transparent,
                elevation: 1,
                child: Container(
                  width: 40,
                  height: 45,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    gradient: RadialGradient(
                      colors: [
                        Color(0xFFFFDDE6),
                        Color(0xFFFFB8CA),
                      ],
                    ),
                  ),
                  child: Image.network(
                    availableRewards[index]['reward']['image'],
                  ),
                ),
              ),
              title: Text(
                availableRewards[index]['reward']['name'],
                style: const TextStyle(
                  fontFamily: 'Walone-B',
                  fontSize: 11,
                  color: Colors.black,
                ),
              ),
              subtitle: languageProvider.lan == 'English'
                  ? RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Redeem before ',
                            style: TextStyle(
                              fontFamily: 'Walone-R',
                              fontSize: 11,
                              color: Color(0xFF6C757D),
                            ),
                          ),
                          TextSpan(
                            text: '14 Jan 2025',
                            style: TextStyle(
                              fontFamily: 'Walone-B',
                              fontSize: 11,
                              color: Color(0xFF2B2F32),
                            ),
                          ),
                        ],
                      ),
                    )
                  : RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'သက်တမ်းကုန်မည့်ရက်စွဲ ',
                            style: TextStyle(
                              fontFamily: 'Walone-B',
                              fontSize: 10,
                              color: Color(0xFF6C757D),
                            ),
                          ),
                          TextSpan(
                            text: '14 Jan 2025',
                            style: TextStyle(
                              fontFamily: 'Walone-B',
                              fontSize: 11,
                              color: Color(0xFF2B2F32),
                            ),
                          ),
                        ],
                      ),
                    ),
              trailing: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RedeemRewardsPage())),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: primaryPinkColor,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
        itemCount: availableRewards.length);
  }
}

class ExpiredRewards extends StatelessWidget {
  final List<dynamic> expiredRewards;
  const ExpiredRewards({super.key, required this.expiredRewards});

  @override
  Widget build(BuildContext context) {
    if (expiredRewards.isEmpty) {
      return const Center(
        child: Text(
          'No rewards yet',
          style: TextStyle(
              fontFamily: 'Bricolage-B',
              fontSize: 11,
              color: Color(0xFF2B2F32)),
        ),
      );
    }
    var languageProvider = Provider.of<LanguageProvider>(context);
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              // placeholder for image
              leading: Material(
                color: Colors.transparent,
                elevation: 1,
                child: Container(
                  width: 40,
                  height: 45,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Color(0xFFE2E3E5),
                  ),
                  child: Image.network(
                    expiredRewards[index]['reward']['image'],
                  ),
                ),
              ),
              title: Text(
                expiredRewards[index]['reward']['name'],
                style: const TextStyle(
                  fontFamily: 'Walone-B',
                  fontSize: 11,
                  color: Color(0xFF6C757D),
                ),
              ),
              subtitle: languageProvider.lan == 'English'
                  ? RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Expired On ',
                            style: TextStyle(
                              fontFamily: 'Walone-R',
                              fontSize: 11,
                              color: Color(0xFF6C757D),
                            ),
                          ),
                          TextSpan(
                            text: '14 Jan 2025',
                            style: TextStyle(
                              fontFamily: 'Walone-B',
                              fontSize: 11,
                              color: Color(0xFF6C757D),
                            ),
                          ),
                        ],
                      ),
                    )
                  : RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'သက်တမ်းကုန်သွားသောရက်စွဲ ',
                            style: TextStyle(
                              fontFamily: 'Walone-B',
                              fontSize: 10,
                              color: Color(0xFF6C757D),
                            ),
                          ),
                          TextSpan(
                            text: '14 Jan 2025',
                            style: TextStyle(
                              fontFamily: 'Walone-B',
                              fontSize: 11,
                              color: Color(0xFF6C757D),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
        itemCount: expiredRewards.length);
  }
}

class RedeemedRewards extends StatelessWidget {
  final List<dynamic> redeemedRewards;
  const RedeemedRewards({super.key, required this.redeemedRewards});
  @override
  Widget build(BuildContext context) {
    if (redeemedRewards.isEmpty) {
      return const Center(
        child: Text(
          'No rewards yet',
          style: TextStyle(
              fontFamily: 'Bricolage-B',
              fontSize: 11,
              color: Color(0xFF2B2F32)),
        ),
      );
    }
    var languageProvider = Provider.of<LanguageProvider>(context);
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              // placeholder for image
              leading: Material(
                color: Colors.transparent,
                elevation: 1,
                child: Container(
                  width: 40,
                  height: 45,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    gradient: RadialGradient(
                      colors: [
                        Color(0xFFFFDDE6),
                        Color(0xFFFFB8CA),
                      ],
                    ),
                  ),
                  child: Image.network(
                    redeemedRewards[index]['reward']['image'],
                  ),
                ),
              ),
              title: Text(
                redeemedRewards[index]['reward']['name'],
                style: const TextStyle(
                  fontFamily: 'Walone-B',
                  fontSize: 11,
                  color: Colors.black,
                ),
              ),
              subtitle: languageProvider.lan == 'English'
                  ? RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Redeem on ',
                            style: TextStyle(
                              fontFamily: 'Walone-R',
                              fontSize: 11,
                              color: Color(0xFF6C757D),
                            ),
                          ),
                          TextSpan(
                            text: '14 Jan 2025',
                            style: TextStyle(
                              fontFamily: 'Walone-B',
                              fontSize: 11,
                              color: Color(0xFF2B2F32),
                            ),
                          ),
                        ],
                      ),
                    )
                  : RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'ရရှိခဲ့သောရက်စွဲ ',
                            style: TextStyle(
                              fontFamily: 'Walone-B',
                              fontSize: 10,
                              color: Color(0xFF6C757D),
                            ),
                          ),
                          TextSpan(
                            text: '14 Jan 2025',
                            style: TextStyle(
                              fontFamily: 'Walone-B',
                              fontSize: 11,
                              color: Color(0xFF2B2F32),
                            ),
                          ),
                        ],
                      ),
                    ),
              trailing: const Icon(
                CupertinoIcons.check_mark_circled,
                color: Color(0xFF28A745),
                size: 18,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
        itemCount: redeemedRewards.length);
  }
}

class AnimatedBox extends StatefulWidget {
  const AnimatedBox({super.key});

  @override
  State<AnimatedBox> createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends State<AnimatedBox>
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
                  'images/giftbox.png',
                  cacheWidth: 70,
                  cacheHeight: 70,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
