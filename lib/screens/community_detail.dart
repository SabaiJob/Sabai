import 'package:flutter/material.dart';
import 'package:sabai_app/constants.dart';

class CommunityDetail extends StatelessWidget {
  const CommunityDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: backgroundColor,
        title: const Text(
          'Details',
          style: appBarTitleStyleEng,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: primaryPinkColor,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey.shade300,
            height: 1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'images/community_detail.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  width: 200,
                  child: Text(
                    textAlign: TextAlign.center,
                    'Labour Rights Promotion Network Foundation (LPN)',
                    style: TextStyle(
                      fontFamily: 'Bricolage-R',
                      fontSize: 15.63,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Category : Labour  Rights',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontFamily: 'Bricolage-R',
                    color: Color(0xff616971),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Contact Information',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Bricolage-M',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Website',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Bricolage-R',
                                  ),
                                ),
                                Text(
                                  'https://th.lpnfoundation.org/',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Bricolage-R',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                            child: Divider(
                              height: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Bricolage-R',
                                  ),
                                ),
                                Text(
                                  'sompongLPN@gmail.com',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Bricolage-R',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                            child: Divider(
                              height: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Phone Number',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Bricolage-R',
                                  ),
                                ),
                                Text(
                                  '+66 84 121 1609',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Bricolage-R',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About the organization',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Bricolage-M',
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Due to the severe damage to the marine life and '
                            'ecosystems of the Gulf of Thailand due to overfishing, and the lack of '
                            'sufficient fishing to sustain demand, seafood companies that want to maintain profits have to send'
                            ' their ships far from the Gulf of Thailand.And because of the difficult'
                            ' working conditions, being far from home, being out in the middle of the '
                            'ocean in foreign seas, there is a shortage of labor on many fishing boats. '
                            'Therefore, they have to rely on human trafficking to find labor to work on the boats. The workers on '
                            'these fishing boats have to suffer from the terrible working conditions on the boats and being out at '
                            'sea for many years.With such “gray” networks and the lack of clarity in the recruitment of labor through '
                            'the brokerage system, all those involved in the seafood business, including factories, importers, exporters,'
                            ' companies, and government officials, have an excuse to deny responsibility or even deny acknowledgment.This'
                            ' is why we need to demand transparency in the supply chains of seafood businesses in order to end the '
                            'existence of slave labor.',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Bricolage-R',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        Container(
          width: 375,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xffFF3997),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Set the border radius
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Contact Now',
              style: TextStyle(
                fontFamily: 'Bricolage-B',
                fontSize: 15.63,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
