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
    // TODO: implement initState
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

  void showInitialBottomSheet() async {
    final randomIndex = await showModalBottomSheet<int>(
      isDismissible: false,
      enableDrag: false,
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      builder: (context) => InitialBottomSheet(
        rewards: rewards,
      ),
    );

    if (randomIndex != null) {
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
                const Text(
                  "🎉 Congratulations!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "You won: $result",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RewardsPage()),
                    (route) => false,
                  ),
                  child: const Text("Redeem the Reward"),
                )
              ],
            ),
          ),
        );
      });
    }
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 400, // Add fixed height
                child: FortuneWheel(
                  animateFirst: false,
                  selected: controller.stream,
                  items: [
                    for (var reward in rewards)
                      FortuneItem(child: Text(reward)),
                  ],
                ),
              ),
              if (spinning == false)
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                )
            ],
          ),
        ),
      ),
    );
  }
}

class InitialBottomSheet extends StatelessWidget {
  const InitialBottomSheet({
    super.key,
    required this.rewards,
  });

  final List<String> rewards;

  @override
  Widget build(BuildContext context) {
    void _spinAndClose() {
      final randomIndex = Fortune.randomInt(0, rewards.length);
      Navigator.pop(context, randomIndex); // Return the index to parent
    }

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
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.23,
            child: GridView.builder(
              itemCount: rewards.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                // return Card(
                //   color: Colors.purple[50],
                //   child: Center(
                //     child: Text(
                //       rewards[index],
                //       textAlign: TextAlign.center,
                //       style: const TextStyle(fontSize: 14),
                //     ),
                //   ),
                // );
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
            onPressed: _spinAndClose,
            icon: const Icon(Icons.casino),
            label: const Text("Spin the Wheel"),
            style: ElevatedButton.styleFrom(
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
