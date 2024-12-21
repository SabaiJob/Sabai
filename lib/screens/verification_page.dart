import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/screens/job_category_page.dart';
import 'package:sabai_app/services/language_provider.dart';

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
    var languageProvider = Provider.of<LanguageProvider>(context);
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
          languageProvider.lan == 'English'
              ? const Text(
                  'Checking Your Profile',
                  style: TextStyle(
                    fontFamily: 'Bricolage-M',
                    fontSize: 24.41,
                  ),
                )
              : const Text(
                  'သင့်ပရိုဖိုင်ကို စစ်ဆေးနေပါပြီ',
                  style: TextStyle(
                    fontFamily: 'Walone-B',
                    fontSize: 24.41,
                  ),
                ),
          const SizedBox(
            height: 5,
          ),
          languageProvider.lan == 'English'
              ? const Text(
                  'We\'ll Be in Touch Within 2 Business Days',
                  style: TextStyle(
                    fontFamily: 'Bricolage-R',
                    fontSize: 15.63,
                  ),
                )
              : const Text(
                  'အများဆုံး ၂ ရက်အတွင်းပြန်လည်ဆက်သွယ်ပါမည်',
                  style: TextStyle(
                    fontFamily: 'Walone-R',
                    fontSize: 14,
                  ),
                ),
        ],
      ),
    );
  }
}
