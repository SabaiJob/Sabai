import 'package:flutter/material.dart';

class SuccessfulApplicationScreen extends StatefulWidget {
  const SuccessfulApplicationScreen({super.key});

  @override
  State<SuccessfulApplicationScreen> createState() => _SuccessfulApplicationScreenState();
}

class _SuccessfulApplicationScreenState extends State<SuccessfulApplicationScreen> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
     _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }
  @override
  void dispose() {
     _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Container(
                        width: 100 + _controller.value * 20,
                        height: 100 + _controller.value * 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.pink[300]?.withOpacity(0.3 - _controller.value * 0.3),
                        ),
                      );
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.pink[300],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                '🎉 Application Sent!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                'Your CV for Barista is on its way.\nKeep an eye out for updates— we’ll let you know the next steps!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    'Explore more jobs',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}