import 'package:flutter/material.dart';

class ListTileButton extends StatelessWidget {
  final Widget? ltLeading;
  final Widget? ltTitle;
  final Widget? ltTrailing;
  final Function()? navTo;
  const ListTileButton(
      {super.key,
      required this.ltLeading,
      required this.ltTitle,
      required this.ltTrailing,
      this.navTo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      leading: ltLeading,
      title: ltTitle,
      trailing: ltTrailing,
      onTap: navTo,
    );
  }
}