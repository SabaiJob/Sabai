import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sabai_app/screens/job_details_page.dart';

class All extends StatelessWidget {
  const All({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> jobTitle = ['Barista', 'Chef', 'Teacher'];
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: ListView.builder(
        itemCount: jobTitle.length, // Total number of items
        itemBuilder: (context, index) {
          return WorkCard(
            jobTitle[index],
          );
        },
      ),
    );
  }
}

class WorkCard extends StatelessWidget {
  final String jobTitle;
  const WorkCard(this.jobTitle);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const JobDetailsPage()));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 25,
                  decoration: const BoxDecoration(
                    color: Color(0xffFFEBF6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'images/status.png',
                        width: 12,
                        height: 12,
                      ),
                      const Text(
                        'Sabai Job Partner',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Bricolage-R',
                          color: Color(0xff6C757D),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Color(0xffF0F1F2),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.heart,
                        color: Color(0xffFF3997),
                      ),
                      iconSize: 18,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobTitle,
                    style: const TextStyle(
                      fontSize: 15.63,
                      fontFamily: 'Bricolage-M',
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      text: 'By ',
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Bricolage-R',
                        color: Color(0xff6C757D),
                      ),
                      children: [
                        TextSpan(
                          text: 'Starbucks Thailand',
                          style: TextStyle(
                            fontFamily: 'Bricolage-B',
                            fontSize: 10,
                            color: Color(0xff6C757D),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Closing in 3 days',
                    style: TextStyle(
                      fontFamily: 'Bricolage-R',
                      fontSize: 10,
                      color: Color(0xffDC3545),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Salary',
                        style: TextStyle(
                          fontFamily: 'Bricolage-R',
                          fontSize: 10,
                          color: Color(0xff6C757D),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 38),
                        child: Row(
                          children: [
                            Text(
                              'Location',
                              style: TextStyle(
                                fontFamily: 'Bricolage-R',
                                fontSize: 10,
                                color: Color(0xff6C757D),
                              ),
                            ),
                            const SizedBox(
                              width: 63,
                            ),
                            const Text(
                              'Safety',
                              style: TextStyle(
                                fontFamily: 'Bricolage-R',
                                fontSize: 10,
                                color: Color(0xff6C757D),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '18000 ~ 28000 THB',
                        style: TextStyle(
                          fontFamily: 'Bricolage-M',
                          fontSize: 12.5,
                          color: Color(0xff4C5258),
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Bangkok',
                            style: TextStyle(
                              fontFamily: 'Bricolage-M',
                              fontSize: 12.5,
                              color: Color(0xff4C5258),
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Card(
                            color: const Color(0xffEAF6EC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    CupertinoIcons.info_circle,
                                    size: 11,
                                    color: Color(0xff28A745),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    'Level-3',
                                    style: TextStyle(
                                      fontFamily: 'Bricolage-R',
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    child: Divider(
                      height: 10,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Icon(
                                Icons.remove_red_eye_outlined,
                                size: 13,
                                color: Color(0xffFF3997),
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            RichText(
                              text: const TextSpan(
                                text: 'viewed by  ',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontFamily: 'Bricolage-R',
                                  color: Color(0xff6C757D),
                                ),
                                children: [
                                  TextSpan(
                                    text: '20',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontFamily: 'Bricolage-B',
                                      color: Color(0xff6C757D),
                                    ),
                                  ),
                                  TextSpan(text: '  job hunters'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              child: Image.asset(
                                'images/give_heart.png',
                                width: 13,
                                height: 13,
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            const Text(
                              '56',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontFamily: 'Bricolage-B',
                                color: Color(0xff6C757D),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
