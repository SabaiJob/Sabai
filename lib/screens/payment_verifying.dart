import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';
import 'package:sabai_app/screens/pricing_plan.dart';

class PaymentVerifying extends StatefulWidget {
  const PaymentVerifying({super.key});

  @override
  State<PaymentVerifying> createState() => _PaymentVerifyingState();
}

class _PaymentVerifyingState extends State<PaymentVerifying>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Set up the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true); // Automatically repeats animation

    // Set up the floating animation
    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (!mounted) return;
        _controller.stop();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const NavigationHomepage()),
          (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEBF6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AvatarGlow(
            glowColor: Colors.white,
            glowCount: 1,
            child: Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, -_animation.value), // Floating effect
                    child: child,
                  );
                },
                child: Image.asset(
                  'images/verifying.png',
                  width: 300,
                  height: 300,
                ),
              ),
            ),
          ),
          const Text(
            'Payment Verification',
            style: TextStyle(
              fontFamily: 'Bricolage-M',
              fontSize: 24.41,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            textAlign: TextAlign.center,
            'Thank you! We\'ll verify your payment within\n2-3 business days.',
            style: TextStyle(
              fontFamily: 'Bricolage-R',
              fontSize: 15.63,
            ),
          ),
        ],
      ),
    );
  }
}
