import 'package:flutter/material.dart';

class ReusableContainer extends StatelessWidget {
  final bool hasError;
  final Widget childWidget;
  const ReusableContainer({super.key, required this.hasError, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(
          color: hasError ? Colors.red : Colors.transparent,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: childWidget,
    );
  }
}
