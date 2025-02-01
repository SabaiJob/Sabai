import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdCard extends StatelessWidget {
  const AdCard({required this.url, this.imageUrl, super.key});

  final String url;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(
          Uri.parse(url),
        )) {
          await launchUrl(
            Uri.parse(url),
            mode: LaunchMode.externalApplication,
          );
        }
      },
      child: Card(
        child: Image.network(
          imageUrl!,
          width: double.infinity,
          height: 200,
        ),
      ),
    );
  }
}
