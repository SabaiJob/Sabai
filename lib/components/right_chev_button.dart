import 'package:flutter/cupertino.dart';
class RightChevronButton extends StatelessWidget {
  const RightChevronButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      CupertinoIcons.right_chevron,
      size: 23,
      color: Color(0xFFFF3997),
    );
  }
}
