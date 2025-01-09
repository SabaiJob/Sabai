import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sabai_app/components/community_card.dart';
import 'package:sabai_app/constants.dart';

class LaborRight extends StatelessWidget {
  LaborRight({super.key});

  final List<String> orgName = [
    'Labour Rights Promotion Network Foundation (LPN)',
    'Migrant Workers Rights Network (MWRN)',
    'Women\'s Empowerment Association (WEA)',
    'Youth Development Initiative (YDI)',
    'Environmental Conservation Society (ECS)',
    'Community Health Alliance (CHA)',
  ];

  final List<String> label = [
    'An NGO dedicated to promoting  ...',
    'A membership-based organization  ...',
    'An organization focused on advancing gender equality and women\'s rights.',
    'A youth-led non-profit organization empowering young people through education and skills development.',
    'Dedicated to protecting the environment and promoting sustainable practices.',
    'An alliance of healthcare professionals dedicated to improving community health and wellness.',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color(0xffF7F7F7),
      child: ListView.builder(
        itemCount: orgName.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: CommunityCard(
              orgName: orgName[index],
              label: label[index],
            ),
          );
        },
      ),
    );
  }
}
