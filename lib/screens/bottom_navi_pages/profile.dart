import 'package:flutter/material.dart';
import 'package:sabai_app/screens/pricing_plan.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PricingPlan(),
              ),
            );
          },
          child: const Icon(
            Icons.monetization_on_outlined,
          ),
        ),
      ),
    );
  }
}
