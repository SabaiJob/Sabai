import 'package:flutter/material.dart';

class CommunityCard extends StatelessWidget {
  const CommunityCard({super.key, required this.orgName, required this.label});

  final String orgName;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, top: 15, right: 15, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/menu_item.png',
                    width: 19,
                    height: 19,
                  ),
                  const SizedBox(
                    width: 20,
                  ), // Add spacing between the icon and text
                  Expanded(
                    // Ensures the text does not overflow
                    child: Text(
                      orgName,
                      style: const TextStyle(
                        fontFamily: 'Bricolage-R',
                        fontSize: 15.63,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, bottom: 10),
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Bricolage-R',
                  fontSize: 12,
                  color: Color(0xff616971),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
