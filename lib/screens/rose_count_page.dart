import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:provider/provider.dart';

// class RoseCountPage extends StatelessWidget {
//   const RoseCountPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var languageProvider = Provider.of<LanguageProvider>(context);

//     return Scaffold(
//       backgroundColor: backgroundColor,
// appBar: AppBar(
//   backgroundColor: Colors.white,
//   bottom: PreferredSize(
//       preferredSize: const Size.fromHeight(1.0),
//       child: Container(
//         color: Colors.grey.shade300,
//         height: 1.0,
//       )),
//   surfaceTintColor: Colors.transparent,
//   shadowColor: Colors.transparent,
//   title: languageProvider.lan == 'English'
//       ? const Text(
//           "Your roses",
//           style: appBarTitleStyleEng,
//         )
//       : const Text(
//           'ကျွန်တော့်နှင်းဆီပွင့်များ',
//           style: appBarTitleStyleMn,
//         ),
//   centerTitle: true,
//   iconTheme: const IconThemeData(
//     color: Color(0xFFFF3997),
//   ),
// ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Curved Background Section

//             ClipPath(
//               //clipBehavior: Clip.none,
//               clipper: InwardCurveClipper(),
//               child: Container(
//                 height: 300,
//                 width: double.infinity, // Adjust as needed
//                 color: const Color(0xFFFED7EA),
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//                           child: Container(
//                             width: 139,
//                             height: 139,
//                             decoration: const BoxDecoration(
//                                 color: Color(0xFFFFEBF6),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(100)),
//                                 border: Border(
//                                   top: BorderSide(
//                                     color: Color(0xFFFF3997),
//                                     width: 5,
//                                   ),
//                                   bottom: BorderSide(
//                                     color: Color(0xFFFF3997),
//                                     width: 5,
//                                   ),
//                                   left: BorderSide(
//                                     color: Color(0xFFFF3997),
//                                     width: 5,
//                                   ),
//                                   right: BorderSide(
//                                     color: Color(0xFFFF3997),
//                                     width: 5,
//                                   ),
//                                 )),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Positioned(
//                         left: 128,
//                         top: 28,
//                         child: Image.asset(
//                           'icons/rose.png',
//                           width: 120,
//                           height: 120,
//                         )),
//                   ],
//                 ),
//               ),
//             ),

//             // I waant this part to go above
//             Container(
//               color: Colors.grey,
//               padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
//               child: Column(
//                 children: [
//                   const Text('You got 46 roses'),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   const Text('See who gave you roses'),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   const Align(
//                     alignment: Alignment.topLeft,
//                     child: Text('Recent givers'),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
// Container(
//   padding: const EdgeInsets.symmetric(
//       horizontal: 10, vertical: 10),
//   decoration: const BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.all(Radius.circular(16)),
//   ),
//   child: const SizedBox(
//     height:
//         268, // Set the desired height for the scrollable area
//     child: SingleChildScrollView(
//       child: Column(
//         children:  [
//           ListTile(
//             minVerticalPadding: 10,
//             leading: Image(
//               image: AssetImage('icons/temp1.png'),
//               width: 24,
//               height: 24,
//             ),
//             title: Text('LiLi'),
//           ),
//           Divider(color: Color(0xFFF0F1F2)),
//           ListTile(
//             minVerticalPadding: 10,
//             leading: Image(
//               image: AssetImage('icons/temp2.png'),
//               width: 24,
//               height: 24,
//             ),
//             title: Text('Emily Wilson'),
//           ),
//           Divider(color: Color(0xFFF0F1F2)),
//           ListTile(
//             minVerticalPadding: 10,
//             leading: Image(
//               image: AssetImage('icons/temp3.png'),
//               width: 24,
//               height: 24,
//             ),
//             title: Text('Kris Johnson'),
//           ),
//           Divider(color: Color(0xFFF0F1F2)),
//           ListTile(
//             minVerticalPadding: 10,
//             leading: Image(
//               image: AssetImage('icons/temp4.png'),
//               width: 24,
//               height: 24,
//             ),
//             title: Text('Gavin Burns'),
//           ),
//           Divider(color: Color(0xFFF0F1F2)),
//           ListTile(
//             minVerticalPadding: 10,
//             leading: Image(
//               image: AssetImage('icons/temp5.png'),
//               width: 24,
//               height: 24,
//             ),
//             title: Text('Julia Singh'),
//           ),
//           Divider(color: Color(0xFFF0F1F2)),
//           ListTile(
//             minVerticalPadding: 10,
//             leading: Image(
//               image: AssetImage('icons/temp6.png'),
//               width: 24,
//               height: 24,
//             ),
//             title: Text('Tess Fowler'),
//           ),
//         ],
//       ),
//     ),
//   ),
// ),
//                   const SizedBox(
//                     height: 25,
//                   ),
// SizedBox(
//   width: double.infinity,
//   height: 42,
//   child: TextButton(
//     onPressed: () {},
//     style: TextButton.styleFrom(
//       backgroundColor: const Color(0xffFF3997),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(
//             8), // Set the border radius
//       ),
//     ),
//     child: languageProvider.lan == 'English'
//         ? const Text(
//             'Get Rewards',
//             style: TextStyle(
//               color: Colors.white,
//               fontFamily: 'Bricolage-B',
//               fontSize: 15.63,
//             ),
//           )
//         : const Text(
//             'ဆုများရယူမယ်',
//             style: TextStyle(
//               color: Colors.white,
//               fontFamily: 'Walone-B',
//               fontSize: 14,
//             ),

//           ),

//   ),
// ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // CustomClipper for Inward Curve
// class InwardCurveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, size.height - 50); // Start at bottom-left
//     path.quadraticBezierTo(
//       size.width / 2,
//       size.height - 150, // Control point (higher for inward curve)
//       size.width, size.height - 50, // End point
//     );
//     path.lineTo(size.width, 0); // Top-right corner
//     path.close(); // Complete the path
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

class RoseCountPage extends StatefulWidget {
  @override
  State<RoseCountPage> createState() => _RoseCountPageState();
}

class _RoseCountPageState extends State<RoseCountPage> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFED7EA), // Background for the app
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey.shade300,
              height: 1.0,
            )),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: languageProvider.lan == 'English'
            ? const Text(
                "Your roses",
                style: appBarTitleStyleEng,
              )
            : const Text(
                'ကျွန်တော့်နှင်းဆီပွင့်များ',
                style: appBarTitleStyleMn,
              ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xFFFF3997),
        ),
      ),
      body: Column(
        children: [
          // Curved Header Section
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFFED7EA),
                ),
              ),
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                            color: Color(0xFFFFEBF6),
                            shape: BoxShape.circle,
                            border: Border(
                              top: BorderSide(
                                color: Color(0xFFFF3997),
                                width: 5,
                              ),
                              bottom: BorderSide(
                                color: Color(0xFFFF3997),
                                width: 5,
                              ),
                              left: BorderSide(
                                color: Color(0xFFFF3997),
                                width: 5,
                              ),
                              right: BorderSide(
                                color: Color(0xFFFF3997),
                                width: 5,
                              ),
                            )),
                        child: Image.asset(
                          'icons/rose.png',
                          width: 120,
                          height: 120,
                        )),
                  ],
                ),
              ),
            ],
          ),

          //const SizedBox(height: 80), // Space below header

          // Roses Info and Recent Givers Section
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(290, 100),
                  topRight: Radius.elliptical(290, 100),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  languageProvider.lan == 'English'
                      ? RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                                text: 'You ',
                                style: TextStyle(
                                  color: Color(0xFF4C5258),
                                  fontFamily: 'Bricolage-R',
                                  fontSize: 19.5,
                                )),
                            TextSpan(
                                text: 'got ',
                                style: TextStyle(
                                  color: Color(0xFF4C5258),
                                  fontFamily: 'Bricolage-R',
                                  fontSize: 19.5,
                                )),
                            TextSpan(
                                text: '46 ',
                                style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 19.5,
                                )),
                            TextSpan(
                                text: 'roses!',
                                style: TextStyle(
                                  color: Color(0xFF4C5258),
                                  fontFamily: 'Bricolage-R',
                                  fontSize: 19.5,
                                )),
                          ]),
                        )
                      : RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                                text: 'နှင်းဆီ ',
                                style: TextStyle(
                                  color: Color(0xFF4C5258),
                                  fontFamily: 'Walone-B',
                                  fontSize: 19.5,
                                )),
                            TextSpan(
                                text: '၄၆ ',
                                style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'Walone-B',
                                  fontSize: 19.5,
                                )),
                            TextSpan(
                                text: 'ပွင့်ရခဲ့ပြီ!',
                                style: TextStyle(
                                  color: Color(0xFF4C5258),
                                  fontFamily: 'Walone-B',
                                  fontSize: 19.5,
                                )),
                          ]),
                        ),
                  const SizedBox(height: 10),
                  Text(
                    languageProvider.lan == 'English'
                        ? 'See who gave you roses.'
                        : 'ဘယ်သူတွေပေးတာလဲကြည့်မယ်',
                    style: languageProvider.lan == 'English'
                        ? const TextStyle(
                            color: Color(0xFF4C5258),
                            fontFamily: 'Bricolage-R',
                            fontSize: 12.5)
                        : const TextStyle(
                            color: Color(0xFF4C5258),
                            fontFamily: 'Walone-B',
                            fontSize: 11),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      languageProvider.lan == 'English'
                          ? 'Recent givers'
                          : 'လက်တလောပေးထားသူများ',
                      style: languageProvider.lan == 'English'
                          ? const TextStyle(
                              fontSize: 12.5,
                              fontFamily: 'Bricolage-R',
                              color: Color(0xFF6C757D))
                          : const TextStyle(
                              fontSize: 11,
                              fontFamily: 'Walone-B',
                              color: Color(0xFF6C757D)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: const SizedBox(
                        height:
                            268, // Set the desired height for the scrollable area
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListTile(
                                minVerticalPadding: 5,
                                minTileHeight: 10,
                                leading: Image(
                                  image: AssetImage('icons/temp1.png'),
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text(
                                  'LiLi',
                                  style: TextStyle(
                                    fontFamily: 'Bricolage-R',
                                    color: Color(0xFF6C757D),
                                    fontSize: 15.63,
                                  ),
                                ),
                              ),
                              Divider(color: Color(0xFFF0F1F2)),
                              ListTile(
                                minVerticalPadding: 5,
                                minTileHeight: 10,
                                leading: Image(
                                  image: AssetImage('icons/temp2.png'),
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text(
                                  'Emily Wilson',
                                  style: TextStyle(
                                    fontFamily: 'Bricolage-R',
                                    color: Color(0xFF6C757D),
                                    fontSize: 15.63,
                                  ),
                                ),
                              ),
                              Divider(color: Color(0xFFF0F1F2)),
                              ListTile(
                                minVerticalPadding: 5,
                                minTileHeight: 10,
                                leading: Image(
                                  image: AssetImage('icons/temp3.png'),
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text(
                                  'Kris Johnson',
                                  style: TextStyle(
                                    fontFamily: 'Bricolage-R',
                                    color: Color(0xFF6C757D),
                                    fontSize: 15.63,
                                  ),
                                ),
                              ),
                              Divider(color: Color(0xFFF0F1F2)),
                              ListTile(
                                minVerticalPadding: 5,
                                minTileHeight: 10,
                                leading: Image(
                                  image: AssetImage('icons/temp4.png'),
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text(
                                  'Gavin Burns',
                                  style: TextStyle(
                                    fontFamily: 'Bricolage-R',
                                    color: Color(0xFF6C757D),
                                    fontSize: 15.63,
                                  ),
                                ),
                              ),
                              Divider(color: Color(0xFFF0F1F2)),
                              ListTile(
                                minVerticalPadding: 5,
                                minTileHeight: 10,
                                leading: Image(
                                  image: AssetImage('icons/temp5.png'),
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text(
                                  'Julia Singh',
                                  style: TextStyle(
                                    fontFamily: 'Bricolage-R',
                                    color: Color(0xFF6C757D),
                                    fontSize: 15.63,
                                  ),
                                ),
                              ),
                              Divider(color: Color(0xFFF0F1F2)),
                              ListTile(
                                minVerticalPadding: 5,
                                minTileHeight: 10,
                                leading: Image(
                                  image: AssetImage('icons/temp6.png'),
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text(
                                  'Tess Fowler',
                                  style: TextStyle(
                                    fontFamily: 'Bricolage-R',
                                    color: Color(0xFF6C757D),
                                    fontSize: 15.63,
                                  ),
                                ),
                              ),
                               Divider(color: Color(0xFFF0F1F2)),
                              ListTile(
                                minVerticalPadding: 5,
                                minTileHeight: 10,
                                leading: Image(
                                  image: AssetImage('icons/temp6.png'),
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text(
                                  'Someone',
                                  style: TextStyle(
                                    fontFamily: 'Bricolage-R',
                                    color: Color(0xFF6C757D),
                                    fontSize: 15.63,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
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
                      child: languageProvider.lan == 'English'
                          ? const Text(
                              'Get Rewards',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Bricolage-B',
                                fontSize: 15.63,
                              ),
                            )
                          : const Text(
                              'ဆုများရယူမယ်',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Walone-B',
                                fontSize: 14,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
