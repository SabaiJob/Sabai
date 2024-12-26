import 'package:flutter/material.dart';

class PricingPlan extends StatefulWidget {
  const PricingPlan({super.key});

  @override
  State<PricingPlan> createState() => _PricingPlanState();
}

class _PricingPlanState extends State<PricingPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pricing plan'),
      ),
    );
  }
}
