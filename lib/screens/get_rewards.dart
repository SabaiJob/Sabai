import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/services/language_provider.dart';

class GetRewardsPage extends StatefulWidget {
  const GetRewardsPage({super.key});

  @override
  State<GetRewardsPage> createState() => _GetRewardsPageState();
}

class _GetRewardsPageState extends State<GetRewardsPage> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
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
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('You got 46 roses!'),
                        Divider(),
                        Text('How to earn roses ?')
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
                  color: Colors.grey.shade200, // Background color for tab bar
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
              width: 200,
              height: 200,
              child: TabBarView(children: [
                Center(
                  child: Text('Available'),
                ),
                Center(
                  child: Text('Expired'),
                ),
                Center(
                  child: Text('Redeemed'),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
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


// import 'package:flutter/material.dart';



// class RewardsScreen extends StatelessWidget {
//   final List<String> rewards = List.generate(5, (index) => "Sabai Job Tote Bag");

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         backgroundColor: Colors.pink[50],
//         appBar: AppBar(
//           backgroundColor: Colors.pink[50],
//           elevation: 0,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.pink),
//             onPressed: () {},
//           ),
//           title: Text(
//             "My Rewards",
//             style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//         ),
//         body: Column(
//           children: [
//             SizedBox(height: 10),
            
//             // Gift Icon
//             CircleAvatar(
//               radius: 40,
//               backgroundColor: Colors.white,
//               child: Image.asset("assets/gift.png", width: 50),
//             ),
            
//             SizedBox(height: 15),
            
//             // Roses Count Card
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     children: [
//                       Text("You got", style: TextStyle(fontSize: 16)),
//                       Text(
//                         "46 roses!",
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink),
//                       ),
//                       SizedBox(height: 5),
//                       TextButton(
//                         onPressed: () {},
//                         child: Text("How to earn roses?", style: TextStyle(color: Colors.pink)),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
            
//             SizedBox(height: 10),
            
//             // Tab Bar
            // TabBar(
            //   labelColor: Colors.pink,
            //   unselectedLabelColor: Colors.grey,
            //   indicatorColor: Colors.pink,
            //   tabs: [
            //     Tab(text: "Available"),
            //     Tab(text: "Expired"),
            //     Tab(text: "Redeemed"),
            //   ],
            // ),
            
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   RewardsList(rewards: rewards),
//                   Center(child: Text("No expired rewards")),
//                   Center(child: Text("No redeemed rewards")),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Reward List Widget
// class RewardsList extends StatelessWidget {
//   final List<String> rewards;
  
//   RewardsList({required this.rewards});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: EdgeInsets.all(10),
//       itemCount: rewards.length,
//       itemBuilder: (context, index) {
//         return Card(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//           child: ListTile(
//             contentPadding: EdgeInsets.all(10),
//             leading: ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.asset("assets/tote_bag.png", width: 50),
//             ),
//             title: Text(rewards[index], style: TextStyle(fontWeight: FontWeight.bold)),
//             subtitle: Text("Redeem before 14 Jan 2025", style: TextStyle(color: Colors.grey)),
//             trailing: Icon(Icons.arrow_forward_ios, color: Colors.pink),
//           ),
//         );
//       },
//     );
//   }
// }
