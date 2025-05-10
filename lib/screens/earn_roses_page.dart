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
          ),
        ),
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
            // Header with animation
            Container(
              height: 150,
              width: double.infinity,
              color: const Color(0xFFFED7EA),
              child: const Center(
                child: AnimatedBox(),
              ),
            ),
            
            // FAQ Content
            Container(
              margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  buildFAQ(
                    "How can I earn roses?", 
                    "You can earn roses by contributing job opportunities to the Sabai Job community. Share job posts by either:\n• Pasting the job link.\n• Uploading a photo of the job details.",
                    "နှင်းဆီပွင့်ဘယ်လိုရယူကြမလဲ?",
                    "Sabai Job အသိုင်းအဝိုင်းအတွက် အလုပ်အကိုင်အခွင့်အလမ်းများ ပံ့ပိုးပေးခြင်းဖြင့် သင်သည် နှင်းဆီပန်းများကို ရရှိနိုင်မည်ဖြစ်သည်။ အလုပ်ပို့စ်များကို \nအလုပ်လင့်ခ်ကို ကူးထည့်ခြင်းသော်လည်းကောင်း \nအလုပ်အသေးစိတ်ဓာတ်ပုံကို အပ်လုဒ်လုပ်ခြင်းသော်လည်ကောင်းမျှဝေပါ",
                    context
                  ),
                  buildFAQ(
                    "What happens after I share a job post?",
                    "Once your job post is live, other users who find it helpful can endorse you by giving you roses.",
                    "အလုပ်ပို့စ်တစ်ခုကို မျှဝေပြီးနောက် ဘာဖြစ်သွားမလဲ။",
                    "သင့်အလုပ်ရာထူးကို တိုက်ရိုက်လွှင့်ပြီးသည်နှင့် ၎င်းကို အထောက်အကူဖြစ်စေသော အခြားအသုံးပြုသူများသည် သင့်အား နှင်းဆီပန်းများပေးခြင်းဖြင့် သင့်အား ထောက်ခံနိုင်ပါသည်။",
                    context
                  ),
                  buildFAQ(
                    "Can I earn roses for every job post I share?",
                    "Yes! As long as your post helps others, you'll earn roses through endorsements.",
                    "ကျွန်တော်မျှဝေတဲ့ အလုပ်ပို့စ်တိုင်းအတွက် နှင်းဆီပန်းကို ရနိုင်ပါသလား။",
                    "ဟုတ်တယ်! သင့်ပို့စ်သည် အခြားသူများကို ကူညီပေးသရွေ့ ထောက်ခံမှုများဖြင့် နှင်းဆီပန်းများကို သင်ရရှိမည်ဖြစ်သည်။",
                    context
                  ),
                  buildFAQ(
                    "Is there a limit to how many roses I can earn?",
                    "There's no limit! The more helpful your contributions, the more roses you can collect.",
                    "နှင်းဆီဘယ်နှစ်ပွင့်ရနိုင်တယ်ဆိုတာကန့်သတ်ချက်ရှိပါသလား။",
                    "အကန့်အသတ်မရှိ! သင်၏အလှူငွေများကို ပိုမိုအထောက်အကူဖြစ်စေလေ၊ နှင်းဆီပန်းများစုဆောင်းနိုင်လေလေဖြစ်သည်။",
                    context
                  ),
                  buildFAQ(
                    "How do I know if someone endorsed my post?",
                    "You'll be notified when someone gives you a rose for your helpful post.",
                    "တစ်စုံတစ်ယောက်သည် ကျွန်ုပ်၏ပို့စ်ကို ထောက်ခံခြင်း ရှိ၊ မရှိ မည်သို့သိနိုင်မည်နည်း။",
                    "သင့်အတွက် အထောက်အကူဖြစ်စေမည့် ပို့စ်အတွက် တစ်စုံတစ်ယောက်က သင့်အား နှင်းဆီတစ်ပွင့်ပေးသောအခါ သင့်ကို အကြောင်းကြားပါမည်။",
                    context
                  ),
                  buildFAQ(
                    "What can I do with the roses I earn?",
                    "You can use roses to unlock exclusive rewards, like phone, tote bag, key chain, T Shirts, etc.",
                    "ကျွန်ုပ်ရရှိထားသည့် နှင်းဆီပန်းများနှင့်မည်သည်များလုပ်နိုင်မည်နည်း",
                    "ဖုန်း၊ အိတ်၊ သော့ချိတ်၊ တီရှပ်များ အစရှိသည့် သီးသန့်ဆုလာဘ်များကို ရရှိရန် နှင်းဆီပန်းများကို အသုံးပြုနိုင်သည်။",
                    context
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), 
          ],
        ),
      ),
    );
  }
}

Widget buildFAQ(String questionEng, String answerEng, String questionMm,
    String answerMm, BuildContext context) {
  var languageProvider = Provider.of<LanguageProvider>(context);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          languageProvider.lan == 'English' ? questionEng : questionMm,
          style: const TextStyle(
            fontFamily: 'Walone-B',
            fontSize: 14,
          ),
        ),
        //const SizedBox(height: 8),
        Text(
          languageProvider.lan == 'English' ? answerEng : answerMm,
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
