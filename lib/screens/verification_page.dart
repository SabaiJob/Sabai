import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:sabai_app/screens/job_category_page.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Set up the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true); // Automatically repeats animation

    // Set up the bounce animation
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (!mounted) return;
        _controller.stop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const JobCategoryPage(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEBF6),
      body: AvatarGlow(
        glowColor: Colors.white,
        glowCount: 1,
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Image.asset(
              'images/verifying.png',
              width: 300,
              height: 300,
            ),
          ),
        ),
      ),
    );
  }
}
