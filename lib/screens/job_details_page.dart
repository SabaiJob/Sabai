import 'package:flutter/material.dart';
import 'package:sabai_app/components/reusable_bulletpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:sabai_app/constants.dart';

class JobDetailsPage extends StatefulWidget {
  const JobDetailsPage({super.key});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Job Details',
          style: appBarTitleStyleEng,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Barista',
                style: TextStyle(
                  fontSize: 19.53,
                  fontFamily: 'Bricolage-M',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 343,
                height: 228,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Sabai Job Partner Tag
                    Container(
                        width: 116,
                        height: 21,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFEBF6),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              topLeft: Radius.circular(8)),
                        ),
                        child: const Row(
                          children: [
                            Image(
                              image: AssetImage('images/status.png'),
                              width: 12,
                              height: 12,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Sabai Job Partner',
                              style: TextStyle(
                                  fontFamily: 'Bricolage-R',
                                  fontSize: 10,
                                  color: Color(0xFF6C757D)),
                            ),
                          ],
                        )),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Offered by',
                                style: TextStyle(
                                  color: Color(0xFF6C757D),
                                  fontFamily: 'Bricolage-R',
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'The Walt Disney Company',
                                style: TextStyle(
                                  color: Color(0xFF4C5258),
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 12.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Salary',
                                style: TextStyle(
                                  color: Color(0xFF6C757D),
                                  fontFamily: 'Bricolage-R',
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('18000 ~ 28000 THB',
                                  style: TextStyle(
                                    color: Color(0xFF4C5258),
                                    fontFamily: 'Bricolage-M',
                                    fontSize: 12.5,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Status',
                                style: TextStyle(
                                  color: Color(0xFF6C757D),
                                  fontFamily: 'Bricolage-R',
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEAF6EC),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                width: 65,
                                height: 21,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      size: 15,
                                      color: Color(0xFF28A745),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'Level - 3',
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Location',
                                style: TextStyle(
                                  color: Color(0xFF6C757D),
                                  fontFamily: 'Bricolage-R',
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Bangkok',
                                  style: TextStyle(
                                    color: Color(0xFF4C5258),
                                    fontFamily: 'Bricolage-M',
                                    fontSize: 12.5,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Job Summary',
                style: TextStyle(
                  fontSize: 15.63,
                  fontFamily: 'Bricolage-M',
                  color: Color(0xFF363B3F),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'A Barista is responsible for preparing and serving a variety of coffee and tea beverages, ensuring high-quality customer service, and maintaining a clean and organized work environment.',
                style: TextStyle(
                  fontFamily: 'Bricolage-R',
                  color: Color(0xFF4C5258),
                  fontSize: 12.5,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Responsibilities',
                style: TextStyle(
                  fontSize: 15.63,
                  fontFamily: 'Bricolage-M',
                  color: Color(0xFF363B3F),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const ReusableBulletPoints(
                  content:
                      'Prepare and serve a variety of coffee and tea beverages, following standardized recipes.'),
              const ReusableBulletPoints(
                  content:
                      ' Take customer orders and provide product recommendations.'),
              const ReusableBulletPoints(
                  content:
                      'Operate coffee-making equipment, including espresso machines, grinders, and brewing devices.'),
              const ReusableBulletPoints(
                  content:
                      'Handle customer transactions, including cash and credit card payments.'),
              const ReusableBulletPoints(
                  content:
                      'Maintain a clean and organized work environment, including regular cleaning of equipment and customer areas.'),
              const ReusableBulletPoints(
                  content:
                      'Follow food safety and sanitation guidelines to ensure a safe and hygienic workspace.'),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Qualifications',
                style: TextStyle(
                  fontSize: 15.63,
                  fontFamily: 'Bricolage-M',
                  color: Color(0xFF363B3F),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const ReusableBulletPoints(
                  content: 'Excellent communication and interpersonal skills.'),
              const ReusableBulletPoints(
                  content:
                      'Being Fluent in Thai language and English language '),
              const ReusableBulletPoints(
                  content:
                      'Passion for coffee and a willingness to learn about different brewing methods.'),
              const ReusableBulletPoints(
                  content:
                      'Ability to work efficiently in a fast-paced environment.'),
              const ReusableBulletPoints(
                  content:
                      'Prior experience as a barista or in a customer service role is preferred but not required.'),
              const ReusableBulletPoints(
                  content:
                      'Attention to detail and commitment to maintaining high-quality standards.'),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                width: 343,
                height: 142,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFE2E3E5),
                      width: 2.0,
                    ),
                    bottom: BorderSide(
                      color: Color(0xFFE2E3E5),
                      width: 2.0,
                    ),
                    left: BorderSide(
                      color: Color(0xFFE2E3E5),
                      width: 2.0,
                    ),
                    right: BorderSide(
                      color: Color(0xFFE2E3E5),
                      width: 2.0,
                    ),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Contributed by',
                          style: TextStyle(
                            color: Color(0xFF6C757D),
                            fontFamily: 'Bricolage-R',
                            fontSize: 10,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Color(0xFFE2E3E5),
                                width: 2.0,
                              ),
                              bottom: BorderSide(
                                color: Color(0xFFE2E3E5),
                                width: 2.0,
                              ),
                              left: BorderSide(
                                color: Color(0xFFE2E3E5),
                                width: 2.0,
                              ),
                              right: BorderSide(
                                color: Color(0xFFE2E3E5),
                                width: 2.0,
                              ),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          width: 78,
                          height: 25,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image(
                                image: AssetImage('images/rose.png'),
                                width: 12,
                                height: 15.26,
                              ),
                              Text(
                                'Say Thanks',
                                style: TextStyle(
                                  fontFamily: 'Bricolage-R',
                                  fontSize: 10,
                                  color: Color(0xFFFF4DA1),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const Row(
                      children: [
                        Image(
                          image: AssetImage('images/Lili.png'),
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'LiLi',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontFamily: 'Bricolage-R',
                            color: Color(0xFF6C757D),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 311,
                      child: Divider(),
                    ),
                    const Row(
                      children: [
                        Text('Interested by',
                            style: TextStyle(
                              color: Color(0xFF6C757D),
                              fontFamily: 'Bricolage-R',
                              fontSize: 10,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                              left: 0,
                              child: Image(
                                image: AssetImage('images/avatar1.png'),
                                width: 24,
                                height: 24,
                              )),
                          Positioned(
                              left: 12,
                              child: Image(
                                image: AssetImage('images/avatar2.png'),
                                width: 24,
                                height: 24,
                              )),
                          Positioned(
                              left: 24,
                              child: Image(
                                image: AssetImage('images/avatar3.png'),
                                width: 24,
                                height: 24,
                              )),
                          Positioned(
                              left: 36,
                              child: Image(
                                image: AssetImage('images/avatar4.png'),
                                width: 24,
                                height: 24,
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 287,
              height: 42,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffFF3997),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Set the border radius
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Apply Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Bricolage-B',
                        fontSize: 15.63,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      CupertinoIcons.arrow_right,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 40,
              height: 42,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 230, 233, 235),
                        width: 1.5,
                      )),
                ),
                onPressed: () {},
                child: const Image(
                  image: AssetImage('images/share_icon.png'),
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
