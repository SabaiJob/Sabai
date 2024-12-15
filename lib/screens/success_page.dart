import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sabai_app/screens/homepage.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Homepage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/success_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AvatarGlow(
                glowColor: Colors.pinkAccent,
                child: Container(
                  width: 94,
                  height: 94,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffFF3997),
                  ),
                  child: const Icon(
                    CupertinoIcons.check_mark,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Take a bow',
                style: TextStyle(
                  fontFamily: 'Bricolage-M',
                  fontSize: 30.52,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Congratulations! Your profile is all set up.',
                style: TextStyle(
                  fontFamily: 'Bricolage-R',
                  fontSize: 15.63,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
