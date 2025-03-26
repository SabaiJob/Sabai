import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const CustomProgressBar({
    super.key, 
    required this.totalSteps, 
    required this.currentStep
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        return Expanded(
          child: Container(
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFcdcfd1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: index <= currentStep 
                ? (index == currentStep 
                  ? (currentStep % 1) 
                  : 1.0) 
                : 0.0,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFF3997), // Match your existing pink color
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}