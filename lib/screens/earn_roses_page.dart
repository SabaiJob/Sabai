import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/services/language_provider.dart';

class EarnRosesPage extends StatefulWidget {
  const EarnRosesPage({super.key});

  @override
  State<EarnRosesPage> createState() => _EarnRosesPageState();
}

class _EarnRosesPageState extends State<EarnRosesPage> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
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
                  "How to earn roses?",
                  style: appBarTitleStyleEng,
                )
              : const Text(
                  'How to earn roses?',
                  style: appBarTitleStyleMn,
                ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color(0xFFFF3997),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildFAQ(
                            "How can I earn roses?",
                            "You can earn roses by contributing job opportunities to the Sabai Job community. Share job posts by either:\n• Pasting the job link.\n• Uploading a photo of the job details.",
                          ),
                          buildFAQ(
                            "What happens after I share a job post?",
                            "Once your job post is live, other users who find it helpful can endorse you by giving you roses.",
                          ),
                          buildFAQ(
                            "Can I earn roses for every job post I share?",
                            "Yes! As long as your post helps others, you'll earn roses through endorsements.",
                          ),
                          buildFAQ(
                            "Is there a limit to how many roses I can earn?",
                            "There's no limit! The more helpful your contributions, the more roses you can collect.",
                          ),
                          buildFAQ(
                            "How do I know if someone endorsed my post?",
                            "You'll be notified when someone gives you a rose for your helpful post.",
                          ),
                          buildFAQ(
                            "What can I do with the roses I earn?",
                            "You can use roses to unlock exclusive rewards, like phone, tote bag, key chain, T Shirts, etc.",
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

Widget buildFAQ(String question, String answer) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
            fontFamily: 'Walone-B',
            fontSize: 14,
          ),
        ),
        //const SizedBox(height: 8),
        Text(
          answer,
          style: const TextStyle(
              fontFamily: 'Walone-R', fontSize: 11, color: Color(0xFF2B2F32)),
        ),
      ],
    ),
  );
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
                  'icons/rose.png',
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
