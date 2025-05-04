import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/services/language_provider.dart';

class TnCBulletPoints extends StatelessWidget {
  final String? content;
  const TnCBulletPoints({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding:  EdgeInsets.only(top: 6.5),
            child:  Icon(
              Icons.circle,
              size: 6,
              color: Colors.pink,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              content!,
              style: languageProvider.lan == 'English'
                  ? const TextStyle(
                      fontSize: 11,
                      fontFamily: 'Walone-B',
                      color: Colors.black
                    )
                  : const TextStyle(
                      fontSize: 11,
                      fontFamily: 'Walone-B',
                      color: Colors.black
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
