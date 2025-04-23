// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/get_rewards.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({super.key});

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  final StreamController<int> controller = StreamController<int>();
  final List<String> rewards = [
    'Samsung',
    'Bag',
    'Keychain',
    'iPhone',
    'iPad',
    'MacBook',
  ];
  bool spinning = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showInitialBottomSheet();
    });
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  void spinWheel() {
    // Check if the bottom sheet is still open before popping
    if (ModalRoute.of(context)?.isCurrent != true) {
      Navigator.pop(context); // Close the bottom sheet if open
    }
    final randomIndex = Fortune.randomInt(0, rewards.length);
    controller.add(randomIndex);
    setState(() {
      spinning = true;
    });
    Future.delayed(const Duration(seconds: 5), () {
      final result = rewards[randomIndex];
      showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        builder: (context) => Container(
          padding: const EdgeInsets.all(24),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Image.asset(
                'images/gift-dynamic-color.png',
                width: 98,
                height: 98,
              ),
              const Text(
                "🎉 Woohoo! You've won !",
                style: TextStyle(
                  fontSize: 19.53,
                  fontFamily: 'Bricolage-M',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                result,
                style: const TextStyle(
                  fontSize: 14,
                  color: primaryPinkColor,
                  fontFamily: 'Walone-B',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const RewardsPage()),
                  (route) => false,
                ),
                label: const Text(
                  "Redeem the Reward",
                  style: TextStyle(
                    fontFamily: 'Bricolage-B',
                    color: Colors.white,
                    fontSize: 15.63,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPinkColor,
                  minimumSize: const Size.fromHeight(50),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void showInitialBottomSheet() async {
    await showModalBottomSheet<int>(
      // isDismissible: false,
      // enableDrag: false,
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      builder: (context) => InitialBottomSheet(
        rewards: rewards,
        onSpinPressed: spinWheel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF88C0),
        title: const Text(
          'Spin Wheel',
          style: TextStyle(
              fontFamily: 'Bricolage-M', fontSize: 19.53, color: Colors.white),
        ),
        actions: [
          Container(
            width: 50,
            height: 30,
            margin: const EdgeInsets.only(right: 15),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFFFEBF6)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'images/rose.png',
                  scale: 2.5,
                ),
                const Text(
                  '46',
                  style: TextStyle(
                    fontSize: 15.6,
                    fontFamily: 'Bricolage-R',
                    color: primaryPinkColor,
                  ),
                )
              ],
            ),
          )
        ],
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFF88C0), Color(0xFFFF3997)])),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 400,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: FortuneWheel(
                    animateFirst: false,
                    selected: controller.stream,
                    items: [
                      for (int i = 0; i < rewards.length; i++)
                        FortuneItem(
                          child: Text(rewards[i]),
                          style: FortuneItemStyle(
                            color: i.isEven
                                ? Colors.white
                                : Colors.blue, // Alternating colors
                            borderColor: Colors.grey[300]!, // Border color
                            borderWidth: 1.0, // Border width
                            textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: i.isEven
                                  ? Colors.black
                                  : Colors.white, // Text color contrast
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (spinning == false) ...[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                )
              ] else ...[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                const Text(
                  'Spinning...',
                  style: TextStyle(
                    fontFamily: 'Bricolage-B',
                    fontSize: 24.41,
                    color: Colors.white,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
      floatingActionButton: spinning
          ? null
          : Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: FloatingActionButton.extended(
                onPressed: spinWheel,
                backgroundColor: Colors.white,
                label: const Text(
                  "Spin wheel for 30 roses",
                  style: TextStyle(
                    fontFamily: 'Bricolage-B',
                    color: primaryPinkColor,
                    fontSize: 15.63,
                  ),
                ),
                //icon: const Icon(Icons.casino, color: Colors.white),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class InitialBottomSheet extends StatelessWidget {
  const InitialBottomSheet({
    super.key,
    required this.rewards,
    required this.onSpinPressed,
  });

  final List<String> rewards;
  final VoidCallback onSpinPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 50,
            height: 5,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const Text(
            'Try Your Luck!',
            style: TextStyle(
                fontSize: 24.4,
                fontFamily: 'Bricolage-B',
                color: primaryPinkColor),
          ),
          const SizedBox(height: 10),
          const Text(
            'Give it a spin and see what you win.',
            style: TextStyle(
                fontFamily: 'Walone-B', fontSize: 14, color: Color(0xFF2B2F32)),
          ),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 5),
          const Text(
            'Prizes',
            style: TextStyle(
                fontSize: 19.5,
                fontFamily: 'Bricolage-B',
                color: primaryPinkColor),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.29,
            child: GridView.builder(
              itemCount: rewards.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                return Material(
                  elevation: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          Color(0xFFFFDDE6),
                          Color(0xFFFFB8CA),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 84,
                          height: 88,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            rewards[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'Bricolage-M', fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: onSpinPressed,
            label: const Text(
              "Spin wheel for 30 roses",
              style: TextStyle(
                fontFamily: 'Bricolage-B',
                color: Colors.white,
                fontSize: 15.63,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryPinkColor,
              minimumSize: const Size.fromHeight(50),
              textStyle: const TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
