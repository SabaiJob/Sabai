import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabai_app/components/change_language_dropdown_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Walkthrough extends StatefulWidget {
  const Walkthrough({super.key});

  @override
  State<Walkthrough> createState() => _WalkthroughState();
}

var dropdownValue = 'English';
final _controller = PageController();

class _WalkthroughState extends State<Walkthrough> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            // Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Main content
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Dropdown at the top
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 25),
                  child: Align(alignment: Alignment.topLeft,child: DropDown()),
                    
                  
                ),
                const SizedBox(
                  height: 50,
                ),
                // PageView with page indicator
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome to',
                          style: GoogleFonts.bricolageGrotesque(
                            textStyle: const TextStyle(
                              fontSize: 24.41,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Sabai Jobs',
                          style: GoogleFonts.bricolageGrotesque(
                            textStyle: const TextStyle(
                              fontSize: 30.52,
                              color: Color(0xffFF3997),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      child: PageView(
                        controller: _controller,
                        children: [
                          Center(
                            child: Text(
                              'Finding a Job Made Easy',
                              style: GoogleFonts.bricolageGrotesque(
                                textStyle: const TextStyle(fontSize: 15.6),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Offering Safe, Hassle-Free Jobs',
                              style: GoogleFonts.bricolageGrotesque(
                                textStyle: const TextStyle(fontSize: 15.6),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Shielding You from Scammers',
                              style: GoogleFonts.bricolageGrotesque(
                                textStyle: const TextStyle(fontSize: 15.6),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Enjoy Job Hunting with Us',
                              style: GoogleFonts.bricolageGrotesque(
                                textStyle: const TextStyle(fontSize: 15.6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 4,
                      effect: const ExpandingDotsEffect(
                        dotHeight: 4,
                        dotWidth: 4,
                        activeDotColor: Color(0xffFF3997),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'By registering, you accept our Terms and Conditions of \n Use and our Privacy Policy.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bricolageGrotesque(
                        textStyle: const TextStyle(
                          fontSize: 12.5,
                          color: Color(0xff4C5258),
                        ),
                      ),
                    ),
                    Container(
                      width: 343,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xffFF3997),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), // Set the border radius
                          ),
                        ),
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.bricolageGrotesque(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.63,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 343,
                      height: 42,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffFF3997),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), // Set the border radius
                          ),
                        ),
                        child: Text(
                          'Log In',
                          style: GoogleFonts.bricolageGrotesque(
                            textStyle: const TextStyle(
                              color: Color(0xffFF3997),
                              fontWeight: FontWeight.bold,
                              fontSize: 15.63,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
    );
  }
}
