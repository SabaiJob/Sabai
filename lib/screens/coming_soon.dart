import 'package:flutter/material.dart';

class ComingSoonPage extends StatefulWidget {
  final Widget? appBarTitle;
  const ComingSoonPage({super.key, required this.appBarTitle});

  @override
  State<ComingSoonPage> createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<ComingSoonPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Animation Controller (Repeats Up & Down Motion)
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: -15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.appBarTitle,
        backgroundColor: const Color(0xFFFFEBF6),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFFEBF6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            
            // Floating Animation for Image
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _floatAnimation.value),
                  child: child,
                );
              },
              child: Image.asset('images/coming-soon.png', height: 267, width: 267),
            ),
            
            const SizedBox(height: 20),

            // Fade-in Animation for Text
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                'Coming Soon 🚀',
                style: TextStyle(
                  fontSize: 19.53,
                  fontFamily: 'Bricolage-SMB',
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Fade-in Animation for Subtitle
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                'We’re working hard to bring you\nsomething amazing. Stay tuned!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.6,
                  fontFamily: 'Bricolage-R',
                  color: Color(0xFF6C757D),
                ),
              ),
            ),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
