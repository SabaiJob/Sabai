import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sabai_app/constants.dart';

class CommunityDetail extends StatefulWidget {
  final int id;
  const CommunityDetail({super.key, required this.id});

  @override
  State<CommunityDetail> createState() => _CommunityDetailState();
}

class _CommunityDetailState extends State<CommunityDetail> {
  Map<String, dynamic>? communityData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCommunityDetails();
  }

   Future<void> fetchCommunityDetails() async {
    final response = await http.get(
      Uri.parse('https://api.sabaijob.com/api/community/${widget.id}/'),
    );

    if (response.statusCode == 200) {
      setState(() {
        communityData = json.decode(utf8.decode(response.bodyBytes));
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

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
      body: isLoading ? const Center(
        child: CircularProgressIndicator(
          color: primaryPinkColor,
        ),
      ) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    communityData!['image'],
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    textAlign: TextAlign.center,
                    communityData!['name'],
                    style: const TextStyle(
                      fontFamily: 'Bricolage-R',
                      fontSize: 15.63,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Category : ${communityData!['category']['name']}',
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontFamily: 'Bricolage-R',
                    color: Color(0xff616971),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Contact Information',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Bricolage-M',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: buildContact('Website', communityData!['website']),
                          ),
                          const SizedBox(
                            height: 5,
                            child: Divider(
                              height: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: buildContact('Email', communityData!['email']),
                          ),
                          const SizedBox(
                            height: 5,
                            child: Divider(
                              height: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: buildContact('Phone Number', communityData!['phone']),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'About the organization',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Bricolage-M',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            communityData!['about'],
                            style: const TextStyle(
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
      persistentFooterButtons: isLoading ? null : [
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

  Row buildContact(String title, String value) {
    return  Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Bricolage-R',
                                ),
                              ),
                              Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Bricolage-R',
                                ),
                              ),
                            ],
                          );
  }
}
