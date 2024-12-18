import 'package:flutter/material.dart';
import 'package:sabai_app/components/reusable_bulletpoints.dart';

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
        title: const Text('Job Details', style: TextStyle(
          fontSize: 19.53,
          fontFamily: 'Bricolage-M',
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:  const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Barista',
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
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), topLeft: Radius.circular(8)),
                      ),
                      child: const Row(
                        children: [
                        Image(image: AssetImage('images/status.png'), 
                        width: 12,
                        height: 12,),
                        SizedBox(width: 5,),
                         Text('Sabai Job Partner', 
                      style: TextStyle(fontFamily: 'Bricolage-R',
                                       fontSize: 10,
                                       color: Color(0xFF6C757D)),),
                          
                      ],)
                    ),
        
                    
        
                     Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                       child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Offered by', style: TextStyle(
                                color: Color(0xFF6C757D),
                                fontFamily: 'Bricolage-R',
                                fontSize: 10,
                              ),),
                               SizedBox(
                              height: 5,
                              ), 
                              Text('The Walt Disney Company', style: TextStyle(
                                color: Color(0xFF4C5258),
                                fontFamily: 'Bricolage-M',
                                fontSize: 12.5,
                              ),),
                              ],
                              ),
                              const SizedBox(
                              height: 10,
                              ),
                            const  Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Salary', style: TextStyle(
                                color: Color(0xFF6C757D),
                                fontFamily: 'Bricolage-R',
                                fontSize: 10,
                              ),), 
                              SizedBox(
                              height: 5,
                              ), 
                              Text('18000 ~ 28000 THB', style: TextStyle(
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
                              const Text('Status', style: TextStyle(
                                color: Color(0xFF6C757D),
                                fontFamily: 'Bricolage-R',
                                fontSize: 10,
                              ),), 
                              const SizedBox(
                              height: 5,
                              ), 
                              Container(
                                decoration: const BoxDecoration(
                                color:  Color(0xFFEAF6EC),
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                ),
                                
                                width: 65,
                                height: 21,
                                
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.info_outline, size: 15, 
                                    color: Color(0xFF28A745),),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text('Level - 3',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),)
                                  ],
                                ),
                              ),
                              ],
                              ),
                              const SizedBox(
                              height: 10,
                              ),
                       
                              const  Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Location', style: TextStyle(
                                color: Color(0xFF6C757D),
                                fontFamily: 'Bricolage-R',
                                fontSize: 10,
                              ),),
                              SizedBox(
                              height: 5,
                              ),  
                              Text('Bangkok', style: TextStyle(
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
              const Text('Job Summary',
              style: TextStyle(
            fontSize: 15.63,
            fontFamily: 'Bricolage-M',
            color: Color(0xFF363B3F),
          ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text('A Barista is responsible for preparing and serving a variety of coffee and tea beverages, ensuring high-quality customer service, and maintaining a clean and organized work environment.',
              style: TextStyle(
                fontFamily: 'Bricolage-R',
                color: Color(0xFF4C5258),
                fontSize: 12.5,
              ),),
              const SizedBox(
                height: 16,
              ),
              const Text('Responsibilities',
              style: TextStyle(
            fontSize: 15.63,
            fontFamily: 'Bricolage-M',
            color: Color(0xFF363B3F),
          ),
              ),
              const SizedBox(
                height: 12,
              ),
              ReusableBulletPoints(content: 'Prepare and serve a variety of coffee and tea beverages, following standardized recipes.'),
              ReusableBulletPoints(content: ' Take customer orders and provide product recommendations.'),
              ReusableBulletPoints(content: 'Operate coffee-making equipment, including espresso machines, grinders, and brewing devices.'),
              ReusableBulletPoints(content: 'Handle customer transactions, including cash and credit card payments.'),
              ReusableBulletPoints(content: 'Maintain a clean and organized work environment, including regular cleaning of equipment and customer areas.'),
              ReusableBulletPoints(content: 'Follow food safety and sanitation guidelines to ensure a safe and hygienic workspace.'),
              const SizedBox(
                height: 16,
              ),
              const Text('Qualifications',
              style: TextStyle(
            fontSize: 15.63,
            fontFamily: 'Bricolage-M',
            color: Color(0xFF363B3F),
          ),
              ),
              const SizedBox(
                height: 12,
              ),
              ReusableBulletPoints(content: 'Excellent communication and interpersonal skills.'),
              ReusableBulletPoints(content: 'Being Fluent in Thai language and English language '),
              ReusableBulletPoints(content: 'Passion for coffee and a willingness to learn about different brewing methods.'),
              ReusableBulletPoints(content: 'Ability to work efficiently in a fast-paced environment.'),
              ReusableBulletPoints(content: 'Prior experience as a barista or in a customer service role is preferred but not required.'),
              ReusableBulletPoints(content: 'Attention to detail and commitment to maintaining high-quality standards.'),
            ],
          ),
        ),
      ),
    );
  }
}