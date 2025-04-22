import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/redeem_rewards_page.dart';
import 'package:sabai_app/screens/rose_count_page.dart';
import 'package:sabai_app/services/language_provider.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
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
                  "My Rewards",
                  style: appBarTitleStyleEng,
                )
              : const Text(
                  'My Rewards',
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
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFED7EA),
                  ),
                ),
                const Positioned(
                    top: 20, left: 0, right: 0, child: AnimatedBox()),
                Positioned(
                  top: 150,
                  left: 20,
                  right: 20,
                  child: Container(
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
                            const Text(
                              'You got 46 roses!',
                              style: TextStyle(
                                  fontFamily: 'Bricolage-SMB',
                                  fontSize: 15.63,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RoseCountPage())),
                              child: const Icon(
                                Icons.arrow_forward_sharp,
                                color: primaryPinkColor,
                              ),
                            )
                          ],
                        ),
                        const Divider(),
                        const Text(
                          'How to earn roses ?',
                          style: TextStyle(
                              fontFamily: 'Walone - B',
                              fontSize: 11,
                              color: Color(0xFF2B2F32),
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFF2B2F32),
                              decorationStyle: TextDecorationStyle.solid),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 45,
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
                  tabs: const [
                    Tab(text: 'Available'),
                    Tab(text: 'Expired'),
                    Tab(text: 'Redeemed'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              width: double.infinity,
              height: 400,
              child: TabBarView(children: [
                Center(
                  child: AvailableRewards(),
                ),
                Center(
                  child: ExpiredRewards(),
                ),
                Center(
                  child: RedeemedRewards(),
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
  const AvailableRewards({super.key});

  @override
  Widget build(BuildContext context) {
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
              leading: Container(
                width: 40,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              title: const Text(
                'Sabai Tote Bag',
                style: TextStyle(
                  fontFamily: 'Walone-B',
                  fontSize: 11,
                  color: Colors.black,
                ),
              ),
              subtitle: RichText(
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
              ),
              trailing: GestureDetector(
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> const RedeemRewardsPage ())),
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
        itemCount: 3);
  }
}

class ExpiredRewards extends StatelessWidget {
  const ExpiredRewards({super.key});

  @override
  Widget build(BuildContext context) {
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
              leading: Container(
                width: 40,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              title: const Text(
                'Sabai Job Tote Bag',
                style: TextStyle(
                  fontFamily: 'Walone-B',
                  fontSize: 11,
                  color: Color(0xFF6C757D),
                ),
              ),
              subtitle: RichText(
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
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
        itemCount: 3);
  }
}

class RedeemedRewards extends StatelessWidget {
  const RedeemedRewards({super.key});
  @override
  Widget build(BuildContext context) {
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
              leading: Container(
                width: 40,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              title: const Text(
                'Sabai Tote Bag',
                style: TextStyle(
                  fontFamily: 'Walone-B',
                  fontSize: 11,
                  color: Colors.black,
                ),
              ),
              subtitle: RichText(
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
        itemCount: 3);
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
