import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:sabai_app/components/divider_line.dart';
import 'package:sabai_app/components/listtile_button.dart';
import 'package:sabai_app/components/right_chev_button.dart';
import 'package:sabai_app/screens/applications_screen.dart';
import 'package:sabai_app/screens/MyCV_screen.dart';
import 'package:sabai_app/screens/about.dart';
import 'package:sabai_app/screens/bottom_navi_pages/save_jobs.dart';
import 'package:sabai_app/screens/coming_soon.dart';
import 'package:sabai_app/screens/contribution_pages/my_contribution.dart';
import 'package:sabai_app/screens/edit_profile.dart';
import 'package:sabai_app/screens/help_and_support.dart';
import 'package:sabai_app/screens/on_premium_page.dart';
import 'package:sabai_app/screens/pricing_plan.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/privacy_policy.dart';
import 'package:sabai_app/screens/auth_pages/api_service.dart';
import 'package:sabai_app/screens/rose_count_page.dart';
import 'package:sabai_app/screens/terms_and_conditions_page.dart';
import 'package:sabai_app/services/image_picker_helper.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:sabai_app/services/payment_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/job_provider.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<String> languages = ['English', 'Myanmar'];
  FileImage? _selectedImage;

  void fetchUserData() async {
    final paymentProvider =
        Provider.of<PaymentProvider>(context, listen: false);
    await paymentProvider.getProfileData(context);
  }

  Future<void> deleteDraft(
      JobProvider jobProvider, PaymentProvider paymentProvider) async {
    String phone = paymentProvider.userPhNo;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('url_$phone');
    await prefs.remove('location_$phone');
    await prefs.remove('isLocated_$phone');
    await prefs.remove('draft_images_$phone');
    await prefs.remove('draftText_$phone');
    jobProvider.setDraft(false);
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<JobProvider>(context, listen: false).fetchContributedJobs(
        false,
        context,
      );
    });
  }

  Future<void> navToEditProfile(PaymentProvider paymentProvider) async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfile(
          initialName: paymentProvider.userData!['username'],
          initialEmail: paymentProvider.userData!['email'] ?? '',
        ),
      ),
    );
    if (updatedData != null) {
      setState(() {
        paymentProvider.userData!['username'] = updatedData["username"];
        paymentProvider.userData!['email'] = updatedData["email"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ImagePickerHelper imagePickerHelper = ImagePickerHelper();
    var languageProvider = Provider.of<LanguageProvider>(context);
    var paymentProvider = Provider.of<PaymentProvider>(context);
    final jobProvider = Provider.of<JobProvider>(context);
    List<bool> isSelected =
        languages.map((lang) => lang == languageProvider.lan).toList();

    if (paymentProvider.userData == null) {
      return const Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: CircularProgressIndicator(
            color: primaryPinkColor,
          ),
        ),
      ); // Show loading state
    }
    return Scaffold(
      backgroundColor: backgroundColor,
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
                "Profile",
                style: appBarTitleStyleEng,
              )
            : const Text(
                'ပရိုဖိုင်',
                style: appBarTitleStyleMn,
              ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xFFFF3997),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Stack(
                children: [
                  _selectedImage != null
                      ? CircleAvatar(
                          radius: 40,
                          foregroundImage: _selectedImage!,
                        )
                      // ? GestureDetector(
                      //     onTap: () {
                      //       showDialog(
                      //           context: context,
                      //           builder: (context) {
                      //             return Dialog(
                      //                 backgroundColor: Colors.transparent,
                      //                 child: Container(
                      //                   decoration: const BoxDecoration(
                      //                     shape: BoxShape.circle,
                      //                   ),
                      //                   child: ClipOval(
                      //                     child: Image.file(
                      //                       _selectedImage!.file,
                      //                       width: 300,
                      //                       height: 300,
                      //                       fit: BoxFit.fill,
                      //                     ),
                      //                   ),
                      //                 ));
                      //           });
                      //     },
                      //     child: CircleAvatar(
                      //       radius: 40,
                      //       foregroundImage: _selectedImage!,
                      //     ),
                      //   )
                      : CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[400],
                          child: ClipOval(
                            child: Image.network(
                              '${paymentProvider.userData?['photo']}',
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        if (Platform.isIOS) {
                          // showCupertinoModalPopup(
                          //   context: context,
                          //   builder: (context) => CupertinoActionSheet(
                          //     actions: [
                          //       CupertinoActionSheetAction(
                          //         onPressed: () async {
                          //           FileImage? image = await imagePickerHelper
                          //               .pickImage(ImageSource.gallery);
                          //           if (image != null) {
                          //             setState(() {
                          //               _selectedImage = image;
                          //             });
                          //           }
                          //         },
                          //         child: Text('Upload New Picture',
                          //             style: TextStyle(
                          //               fontSize: 15,
                          //               color: Colors.grey[600],
                          //             )),
                          //       ),
                          //       CupertinoActionSheetAction(
                          //         onPressed: () {
                          //           setState(() {
                          //             _selectedImage = null;
                          //           });
                          //         },
                          //         child: Text(
                          //           'Remove Profile Picture',
                          //           style: TextStyle(
                          //             fontSize: 15,
                          //             color: Colors.grey[600],
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // );
                          navToEditProfile(paymentProvider);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => EditProfile(
                          //       initialName:
                          //           paymentProvider.userData!['username'],
                          //       initialEmail:
                          //           paymentProvider.userData!['email'],
                          //     ),
                          //   ),
                          // );
                        }
                        if (Platform.isAndroid) {
                          // showModalBottomSheet(
                          //   backgroundColor: Colors.white,
                          //   scrollControlDisabledMaxHeightRatio: 0.25,
                          //   context: context,
                          //   builder: (context) => Padding(
                          //     padding:
                          //         const EdgeInsets.symmetric(horizontal: 15),
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.stretch,
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         ElevatedButton.icon(
                          //           onPressed: () async {
                          //             FileImage? image = await imagePickerHelper
                          //                 .pickImage(ImageSource.gallery);
                          //             if (image != null) {
                          //               setState(() {
                          //                 _selectedImage = image;
                          //               });
                          //             }
                          //           },
                          //           icon: Icon(Icons.image,
                          //               size: 20, color: Colors.grey[600]),
                          //           label: Text(
                          //             'Update Profile Picture',
                          //             style: TextStyle(
                          //                 fontSize: 14,
                          //                 color: Colors.grey[600]),
                          //           ),
                          //           style: ElevatedButton.styleFrom(
                          //             padding: const EdgeInsets.symmetric(
                          //                 vertical: 12, horizontal: 16),
                          //             shape: const RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.all(
                          //                     Radius.circular(8))),
                          //             backgroundColor: const Color.fromARGB(
                          //                 255, 247, 226, 233),
                          //           ),
                          //         ),
                          //         const SizedBox(height: 10),
                          //         OutlinedButton.icon(
                          //           onPressed: () {
                          //             setState(() {
                          //               _selectedImage = null;
                          //             });
                          //           },
                          //           icon: Icon(Icons.delete,
                          //               size: 20, color: Colors.grey[600]),
                          //           label: Text(
                          //             'Remove Profile Picture',
                          //             style: TextStyle(
                          //                 fontSize: 14,
                          //                 color: Colors.grey[600]),
                          //           ),
                          //           style: OutlinedButton.styleFrom(
                          //             shape: const RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.all(
                          //                     Radius.circular(8))),
                          //             padding: const EdgeInsets.symmetric(
                          //                 vertical: 12, horizontal: 16),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // );
                          navToEditProfile(paymentProvider);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => EditProfile(
                          //       initialName:
                          //           paymentProvider.userData!['username'],
                          //       initialEmail:
                          //           paymentProvider.userData!['email'],
                          //     ),
                          //   ),
                          // );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFFFEBF6),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFFED7EA),
                              width: 3,
                            )),
                        padding: const EdgeInsets.all(3),
                        child: const Icon(
                          Icons.edit,
                          color: Color(0xFFFF3997),
                          size: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(paymentProvider.userData!['username'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Bricolage-B',
                    fontSize: 12.5,
                  )),
              const SizedBox(
                height: 5,
              ),

              Text(
                  languageProvider.lan == 'English'
                      ? '${paymentProvider.userData!['phone']}'
                      : '${paymentProvider.userData!['phone']}',
                  style: languageProvider.lan == 'English'
                      ? const TextStyle(
                          color: Color(0xFF6C757D),
                          fontFamily: 'Bricolage-R',
                          fontSize: 10,
                        )
                      : const TextStyle(
                          color: Color(0xFF6C757D),
                          fontFamily: 'Walone-B',
                          fontSize: 10,
                        )),
              const SizedBox(
                height: 20,
              ),

              // Box 1
              Container(
                width: double.infinity,
                height: 75,
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F1F2),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //My Contributions
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyContribution())),
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/give_heart.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  languageProvider.lan == 'English'
                                      ? 'My Contributions'
                                      : 'ကျွန်တော့်ကူညီမှုများ',
                                  style: languageProvider.lan == 'English'
                                      ? const TextStyle(
                                          color: Color(0xFF565E64),
                                          fontFamily: 'Bricolage-R',
                                          fontSize: 10,
                                        )
                                      : const TextStyle(
                                          color: Color(0xFF565E64),
                                          fontFamily: 'Walone-B',
                                          fontSize: 10,
                                        ),
                                ),
                                Text(
                                  languageProvider.lan == 'English'
                                      ? '${jobProvider.contributedJobs.length} Posts'
                                      : '${jobProvider.contributedJobs.length} ပိုစ့်',
                                  style: languageProvider.lan == 'English'
                                      ? const TextStyle(
                                          color: Color(0xFF2B2F32),
                                          fontFamily: 'Bricolage-B',
                                          fontSize: 10,
                                        )
                                      : const TextStyle(
                                          color: Color(0xFF2B2F32),
                                          fontFamily: 'Walone-B',
                                          fontSize: 10,
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    //Striaght Line
                    Container(
                      width: 1,
                      height: 43,
                      color: const Color(0xFFE2E3E5),
                    ),
                    // Rose Counts
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            //RoseCountPage()
                            builder: (context) => RoseCountPage(),
                          ),
                        );
                      },
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            languageProvider.lan == 'English'
                                ? RichText(
                                    text: const TextSpan(children: [
                                      TextSpan(
                                          text: 'Got ',
                                          style: TextStyle(
                                            color: Color(0xFF565E64),
                                            fontFamily: 'Bricolage-R',
                                            fontSize: 10,
                                          )),
                                      TextSpan(
                                          text: '46 ',
                                          style: TextStyle(
                                            color: Color(0xFF2B2F32),
                                            fontFamily: 'Bricolage-B',
                                            fontSize: 10,
                                          )),
                                      TextSpan(
                                          text: 'roses',
                                          style: TextStyle(
                                            color: Color(0xFF565E64),
                                            fontFamily: 'Bricolage-R',
                                            fontSize: 10,
                                          )),
                                    ]),
                                  )
                                : RichText(
                                    text: const TextSpan(children: [
                                      TextSpan(
                                          text: 'နှင်းဆီ ',
                                          style: TextStyle(
                                            color: Color(0xFF565E64),
                                            fontFamily: 'Walone-R',
                                            fontSize: 10,
                                          )),
                                      TextSpan(
                                          text: '၄၆ပွင့် ',
                                          style: TextStyle(
                                            color: Color(0xFF2B2F32),
                                            fontFamily: 'Walone-B',
                                            fontSize: 10,
                                          )),
                                      TextSpan(
                                          text: 'ရခဲ့ပြီ',
                                          style: TextStyle(
                                            color: Color(0xFF565E64),
                                            fontFamily: 'Walone-R',
                                            fontSize: 10,
                                          )),
                                    ]),
                                  ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
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
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F1F2),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: ListTileButton(
                  ltLeading: const Icon(
                    CupertinoIcons.doc,
                    size: 23,
                    color: Color(0xFFFF3997),
                  ),
                  ltTitle: const Text(
                    'My CV',
                    style: TextStyle(
                      fontFamily: 'Bricolage-M',
                      fontSize: 10,
                      color: Color(0xFF2B2F32),
                    ),
                  ),
                  ltTrailing: const RightChevronButton(),
                  navTo: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyCVScreen()));
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Box 2
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F1F2),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    //My Applications
                    ListTileButton(
                      ltLeading: const FaIcon(
                        FontAwesomeIcons.suitcase,
                        size: 23,
                        color: Color(0xFFFF3997),
                      ),
                      ltTitle: const Text(
                        'My Application',
                        style: TextStyle(
                          fontFamily: 'Bricolage-M',
                          fontSize: 10,
                          color: Color(0xFF2B2F32),
                        ),
                      ),
                      ltTrailing: const RightChevronButton(),
                      navTo: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MyApplicationScreen()));
                      },
                    ),
                    const DividerLine(),
                    // Saved Jobs
                    ListTileButton(
                      ltLeading: const Icon(
                        CupertinoIcons.heart,
                        size: 23,
                        color: Color(0xFFFF3997),
                      ),
                      ltTitle: Text(
                        languageProvider.lan == 'English'
                            ? 'Saved Jobs'
                            : 'သိမ်းထားသည့်အလုပ်များ',
                        style: languageProvider.lan == 'English'
                            ? const TextStyle(
                                fontFamily: 'Bricolage-M',
                                fontSize: 10,
                                color: Color(0xFF2B2F32),
                              )
                            : const TextStyle(
                                fontFamily: 'Walone-B',
                                fontSize: 10,
                                color: Color(0xFF2B2F32),
                              ),
                      ),
                      ltTrailing: RightChevronButton(),
                      navTo: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SaveJobs()));
                      },
                    ),
                    const DividerLine(),
                    // Rewards
                    ListTileButton(
                      ltLeading: const Icon(
                        CupertinoIcons.gift,
                        size: 23,
                        color: Color(0xFFFF3997),
                      ),
                      ltTitle: Text(
                        languageProvider.lan == 'English'
                            ? 'Rewards'
                            : 'ဆုများ',
                        style: languageProvider.lan == 'English'
                            ? const TextStyle(
                                fontFamily: 'Bricolage-M',
                                fontSize: 10,
                                color: Color(0xFF2B2F32),
                              )
                            : const TextStyle(
                                fontFamily: 'Walone-B',
                                fontSize: 10,
                                color: Color(0xFF2B2F32),
                              ),
                      ),
                      ltTrailing: const RightChevronButton(),
                      navTo: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ComingSoonPage(
                                    appBarTitle: Text(
                                      'Rewards',
                                      style: appBarTitleStyleEng,
                                    ),
                                  ))),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Box 3
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F1F2),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Pricing Plan
                    ListTileButton(
                      ltLeading: const Icon(
                        CupertinoIcons.money_dollar_circle,
                        size: 23,
                        color: Color(0xFFFF3997),
                      ),
                      ltTitle: Text(
                        languageProvider.lan == 'English'
                            ? 'Pricing Plan'
                            : 'အကောင့်အမျိုးစား',
                        style: languageProvider.lan == 'English'
                            ? const TextStyle(
                                fontFamily: 'Bricolage-M',
                                fontSize: 10,
                                color: Color(0xFF2B2F32),
                              )
                            : const TextStyle(
                                fontFamily: 'Walone-B',
                                fontSize: 10,
                                color: Color(0xFF2B2F32),
                              ),
                      ),
                      ltTrailing: Container(
                        width: 45,
                        height: 15,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEAF6EC),
                          border: Border(
                            top: BorderSide(
                              width: 1.0,
                              color: Color(0xFFD3D6D8),
                            ),
                            left: BorderSide(
                              width: 1.0,
                              color: Color(0xFFD3D6D8),
                            ),
                            bottom: BorderSide(
                              width: 1.0,
                              color: Color(0xFFD3D6D8),
                            ),
                            right: BorderSide(
                              width: 1.0,
                              color: Color(0xFFD3D6D8),
                            ),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color:
                                    paymentProvider.userData!['is_premium'] ==
                                            true
                                        ? const Color(0xfff7d801)
                                        : const Color(0xFF28A745),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            paymentProvider.userData!['is_premium'] == true
                                ? Text(
                                    textAlign: TextAlign.center,
                                    languageProvider.lan == 'English'
                                        ? 'Premium'
                                        : 'အခမဲ့',
                                    style: languageProvider.lan == 'English'
                                        ? const TextStyle(
                                            fontFamily: 'Bricolage-R',
                                            fontSize: 5,
                                          )
                                        : const TextStyle(
                                            fontFamily: 'Walone-B',
                                            fontSize: 10,
                                          ),
                                  )
                                : Text(
                                    textAlign: TextAlign.center,
                                    languageProvider.lan == 'English'
                                        ? 'Free'
                                        : 'အခမဲ့',
                                    style: languageProvider.lan == 'English'
                                        ? const TextStyle(
                                            fontFamily: 'Bricolage-R',
                                            fontSize: 9,
                                          )
                                        : const TextStyle(
                                            fontFamily: 'Walone-B',
                                            fontSize: 10,
                                          ),
                                  )
                          ],
                        ),
                      ),
                      navTo: () {
                        paymentProvider.userData!['is_premium'] == true
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OnPremiumPackage(
                                    datetime: paymentProvider
                                        .userData!['subscription_ends_on'],
                                  ),
                                ),
                              )
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PricingPlan()));
                      },
                    ),
                    const DividerLine(),
                    // Language
                    ListTileButton(
                      ltLeading: const Icon(CupertinoIcons.globe,
                          size: 23, color: Color(0xFFFF3997)),
                      ltTitle: Text(
                        languageProvider.lan == 'English'
                            ? 'Language'
                            : 'ဘာသာစကား',
                        style: languageProvider.lan == 'English'
                            ? const TextStyle(
                                fontFamily: 'Bricolage-M',
                                fontSize: 10,
                                color: Color(0xFF2B2F32),
                              )
                            : const TextStyle(
                                fontFamily: 'Walone-B',
                                fontSize: 10,
                                color: Color(0xFF2B2F32),
                              ),
                      ),
                      ltTrailing: ToggleButtons(
                        constraints: const BoxConstraints(
                          maxWidth: double.infinity,
                          minWidth: 25,
                          minHeight: 20,
                          maxHeight: double.infinity,
                        ),
                        fillColor: const Color(0xFFFF3997),
                        isSelected: isSelected,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        color: Colors.black,
                        onPressed: (int index) {
                          languageProvider.setLan(languages[index]);
                        },
                        children: [
                          Image.asset(
                            'icons/uk.png',
                            width: 15,
                            height: 15,
                          ),
                          Image.asset(
                            'icons/myanmar.png',
                            width: 15,
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Box 4
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F1F2),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Help & Support
                    ListTileButton(
                        ltLeading: const Icon(
                          CupertinoIcons.question_circle,
                          size: 23,
                          color: Color(0xFFFF3997),
                        ),
                        ltTitle: Text(
                          languageProvider.lan == 'English'
                              ? 'Help & Support'
                              : 'အကူညီ',
                          style: languageProvider.lan == 'English'
                              ? const TextStyle(
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                )
                              : const TextStyle(
                                  fontFamily: 'Walone-B',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                ),
                        ),
                        ltTrailing: const RightChevronButton(),
                        navTo: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HelpAndSupport()));
                        }),

                    const DividerLine(),

                    // Terms and Conditions
                    ListTileButton(
                        ltLeading: const Icon(
                          CupertinoIcons.doc_text,
                          size: 23,
                          color: Color(0xFFFF3997),
                        ),
                        ltTitle: Text(
                          languageProvider.lan == 'English'
                              ? 'Terms and Conditions'
                              : 'ထုတ်ပြန်ချက်နှင့် ရေးရာမူဝါဒ',
                          style: languageProvider.lan == 'English'
                              ? const TextStyle(
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                )
                              : const TextStyle(
                                  fontFamily: 'Walone-B',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                ),
                        ),
                        ltTrailing: const RightChevronButton(),
                        navTo: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TermsAndConditionsPage()));
                        }),

                    const SizedBox(
                      width: 311,
                      child: Divider(
                        color: Color(0xFFE2E3E5),
                      ),
                    ),

                    // Privacy Policy
                    ListTileButton(
                        ltLeading: const Icon(
                          CupertinoIcons.checkmark_shield,
                          size: 23,
                          color: Color(0xFFFF3997),
                        ),
                        ltTitle: Text(
                          languageProvider.lan == 'English'
                              ? 'Privacy Policy'
                              : 'ကိုယ်ရေးအချက်အလက် မူဝါဒ',
                          style: languageProvider.lan == 'English'
                              ? const TextStyle(
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                )
                              : const TextStyle(
                                  fontFamily: 'Walone-B',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                ),
                        ),
                        ltTrailing: const RightChevronButton(),
                        navTo: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PrivacyPolicy(),
                            ),
                          );
                        }),

                    const DividerLine(),

                    // about sabai jobs
                    ListTileButton(
                        ltLeading: const Icon(
                          CupertinoIcons.info,
                          size: 23,
                          color: Color(0xFFFF3997),
                        ),
                        ltTitle: Text(
                          languageProvider.lan == 'English'
                              ? 'About Sabai Jobs'
                              : 'Sabai Jobs အကြောင်း',
                          style: languageProvider.lan == 'English'
                              ? const TextStyle(
                                  fontFamily: 'Bricolage-M',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                )
                              : const TextStyle(
                                  fontFamily: 'Walone-B',
                                  fontSize: 10,
                                  color: Color(0xFF2B2F32),
                                ),
                        ),
                        ltTrailing: const Icon(CupertinoIcons.right_chevron,
                            size: 23, color: Color(0xFFFF3997)),
                        navTo: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const About(),
                            ),
                          );
                        })
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          insetPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          backgroundColor: Colors.white,
                          child: SizedBox(
                            width: 320,
                            height: 439,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.dangerous_outlined,
                                      color: primaryPinkColor,
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  'images/log_out.png',
                                  width: 200,
                                  height: 200,
                                ),
                                languageProvider.lan == 'English'
                                    ? const Text(
                                        textAlign: TextAlign.center,
                                        'Are you sure you want to\nlog out?',
                                        style: TextStyle(
                                          fontFamily: 'Bricolage-M',
                                          fontSize: 19.53,
                                          color: Colors.black,
                                        ),
                                      )
                                    : const Text(
                                        textAlign: TextAlign.center,
                                        'အကောင့်မှထွက်ရန်သေချာပြီလား',
                                        style: TextStyle(
                                          fontFamily: 'Walone-B',
                                          fontSize: 19.53,
                                          color: Colors.black,
                                        ),
                                      ),
                                languageProvider.lan == 'English'
                                    ? const SizedBox(
                                        height: 1,
                                      )
                                    : const SizedBox(
                                        height: 15,
                                      ),
                                languageProvider.lan == 'English'
                                    ? const Text(
                                        textAlign: TextAlign.center,
                                        'You can log back in anytime to access your\naccount.',
                                        style: TextStyle(
                                          fontFamily: 'Bricolage-R',
                                          fontSize: 12.5,
                                          color: Color(0xFF6C757D),
                                        ),
                                      )
                                    : const Text(
                                        textAlign: TextAlign.center,
                                        'အချိန်မရွေးပြန်၀င်န်ိုင်ပါသည်',
                                        style: TextStyle(
                                          fontFamily: 'Walone-B',
                                          fontSize: 11,
                                          color: Color(0xFF6C757D),
                                        ),
                                      ),
                                languageProvider.lan == 'English'
                                    ? const SizedBox(
                                        height: 10,
                                      )
                                    : const SizedBox(
                                        height: 30,
                                      ),
                                GestureDetector(
                                  onTap: () async {
                                    deleteDraft(jobProvider, paymentProvider);
                                    await ApiService.logout(context);
                                  },
                                  child: Container(
                                    width: 288,
                                    height: 29,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: const Color(0xFFF0F1F2),
                                      ),
                                    ),
                                    child: Center(
                                      child: languageProvider.lan == 'English'
                                          ? const Text(
                                              textAlign: TextAlign.center,
                                              'Yes, Log Out',
                                              style: TextStyle(
                                                fontFamily: 'Bricolage-R',
                                                fontSize: 12.5,
                                                color: Color(0xFFDC3545),
                                              ),
                                            )
                                          : const Text(
                                              textAlign: TextAlign.center,
                                              'ထွက်မည်',
                                              style: TextStyle(
                                                fontFamily: 'Walone-B',
                                                fontSize: 11,
                                                color: Color(0xFFDC3545),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 288,
                                    height: 29,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: const Color(0xFFF0F1F2),
                                      ),
                                    ),
                                    child: Center(
                                      child: languageProvider.lan == 'English'
                                          ? const Text(
                                              textAlign: TextAlign.center,
                                              'No, Stay within the app',
                                              style: TextStyle(
                                                fontFamily: 'Bricolage-R',
                                                fontSize: 12.5,
                                                color: Color(0xFFFF3997),
                                              ),
                                            )
                                          : const Text(
                                              textAlign: TextAlign.center,
                                              'မထွက်ပါ',
                                              style: TextStyle(
                                                fontFamily: 'Walone-B',
                                                fontSize: 11,
                                                color: Color(0xFFFF3997),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                style: TextButton.styleFrom(
                  fixedSize: const Size(double.infinity, 52),
                  backgroundColor: const Color(0xFFF0F1F2),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Set the border radius
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Color(0xFFFF3997),
                      size: 23,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    languageProvider.lan == 'English'
                        ? const Text(
                            'Log Out',
                            style: TextStyle(
                              fontFamily: 'Bricolage-M',
                              fontSize: 10,
                              color: Color(0xFF2B2F32),
                            ),
                          )
                        : const Text(
                            'အကောင့်မှထွက်မည်',
                            style: TextStyle(
                              fontFamily: 'Walone-B',
                              fontSize: 10,
                              color: Color(0xFF2B2F32),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
