// import 'package:flutter/material.dart';
// import 'dart:math';

// class SuccessRewards extends StatefulWidget {
//   const SuccessRewards({super.key});

//   @override
//   State<SuccessRewards> createState() => _SuccessRewardsState();
// }

// class _SuccessRewardsState extends State<SuccessRewards>
//     with TickerProviderStateMixin {
//   late AnimationController _floatController;
//   late Animation<double> _floatAnimation;

//   late AnimationController _rippleController;

//   @override
//   void initState() {
//     super.initState();

//     // Floating animation
//     _floatController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     )..repeat(reverse: true);

//     _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
//       CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
//     );

//     // Ripple animation
//     _rippleController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat();

//   }

//   @override
//   void dispose() {
//     _floatController.dispose();
//     _rippleController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFCEEF9),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 150,
//             ),
//             // Ripple + Floating image
//             SizedBox(
//               width: double.infinity,
//               height: 350,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   // Ripple effect
//                   AnimatedBuilder(
//                     animation: _rippleController,
//                     builder: (context, child) {
//                       return CustomPaint(
//                         painter: RipplePainter(_rippleController.value),
//                         child: const SizedBox.expand(),
//                       );
//                     },
//                   ),
//                   // Floating image
//                   Positioned(
//                     top: 40,
//                     right: 90,
//                     child: AnimatedBuilder(
//                       animation: _floatAnimation,
//                       builder: (context, child) {
//                         return Transform.translate(
//                           offset: Offset(0, _floatAnimation.value),
//                           child: Image.asset(
//                             'images/rocket.png', // Your image path
//                             width: 260,
//                             height: 260,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             //const SizedBox(height: 10),
//             const Text(
//               'Great Job!',
//               style: TextStyle(
//                 fontSize: 24.41,
//                 fontFamily: 'Bricolage-M',
//               ),
//             ),
//             const SizedBox(height: 12),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 40.0),
//               child: Text(
//                 'Your information has been received, and your reward will be on its way soon.',
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontFamily: 'Walone-B',
//                   color: Color(0xFF2B2F32),
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // CustomPainter for animated ripple effect
// class RipplePainter extends CustomPainter {
//   final double progress;

//   RipplePainter(this.progress);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final maxRadius = min(size.width, size.height) / 2;

//     final rippleCount = 3;

//     for (int i = 0; i < rippleCount; i++) {
//       final double rippleProgress = (progress + i / rippleCount) % 1;
//       final double radius = rippleProgress * maxRadius;
//       final double opacity = (1 - rippleProgress).clamp(0.0, 1.0);

//       final paint = Paint()
//         ..color = Colors.white.withOpacity(opacity * 0.5)
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 2;

//       canvas.drawCircle(center, radius, paint);
//     }
//   }

//   @override
//   bool shouldRepaint(RipplePainter oldDelegate) =>
//       oldDelegate.progress != progress;
// }
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:sabai_app/screens/bottom_navi_pages/profile.dart';

class SuccessRewards extends StatefulWidget {
  const SuccessRewards({super.key});

  @override
  State<SuccessRewards> createState() => _SuccessRewardsState();
}

class _SuccessRewardsState extends State<SuccessRewards>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  late AnimationController _rippleController;

  @override
  void initState() {
    super.initState();

    // Floating animation
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Ripple animation
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Auto navigation after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
      }
    });
  }

  @override
  void dispose() {
    _floatController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCEEF9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 150,
            ),
            // Ripple + Floating image
            SizedBox(
              width: double.infinity,
              height: 350,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Ripple effect
                  AnimatedBuilder(
                    animation: _rippleController,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: RipplePainter(_rippleController.value),
                        child: const SizedBox.expand(),
                      );
                    },
                  ),
                  // Floating image
                  Positioned(
                    top: 40,
                    right: 90,
                    child: AnimatedBuilder(
                      animation: _floatAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _floatAnimation.value),
                          child: Image.asset(
                            'images/rocket.png',
                            width: 260,
                            height: 260,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              'Great Job!',
              style: TextStyle(
                fontSize: 24.41,
                fontFamily: 'Bricolage-M',
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'Your information has been received, and your reward will be on its way soon.',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Walone-B',
                  color: Color(0xFF2B2F32),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RipplePainter extends CustomPainter {
  final double progress;

  RipplePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = min(size.width, size.height) / 2;
    final rippleCount = 3;

    for (int i = 0; i < rippleCount; i++) {
      final double rippleProgress = (progress + i / rippleCount) % 1;
      final double radius = rippleProgress * maxRadius;
      final double opacity = (1 - rippleProgress).clamp(0.0, 1.0);

      final paint = Paint()
        ..color = Colors.white.withOpacity(opacity * 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(RipplePainter oldDelegate) =>
      oldDelegate.progress != progress;
}
