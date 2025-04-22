// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({super.key});

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  final StreamController<int> controller = StreamController<int>();
  final List<String> rewards = [
    '🍕 Free Pizza',
    '🎁 Gift Box',
    '💰 \$10 Cash',
    '🧋 Bubble Tea',
    '🛍️ Shopping Coupon',
    '❌ Try Again',
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
                        builder: (context) => const NavigationHomepage()),
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
      appBar: AppBar(
        title: const Text('Spin to Win'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 400, // Add fixed height
            child: FortuneWheel(
              animateFirst: false,
              selected: controller.stream,
              items: [
                for (var reward in rewards) FortuneItem(child: Text(reward)),
              ],
            ),
          ),
          if (spinning == false)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            )
        ],
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
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(20),
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
            '🎉 Try Your Luck!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text('Give it a spin and see what you win.'),
          const SizedBox(height: 20),
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
                return Card(
                  color: Colors.purple[50],
                  child: Center(
                    child: Text(
                      rewards[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
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
