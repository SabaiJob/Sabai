import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/screens/bottom_navi_pages/community.dart';
import 'package:sabai_app/screens/contribution_pages/contribute_page.dart';
import 'package:sabai_app/screens/bottom_navi_pages/job_listing_page.dart';
import 'package:sabai_app/screens/bottom_navi_pages/profile.dart';
import 'package:sabai_app/screens/bottom_navi_pages/save_jobs.dart';
import 'package:sabai_app/screens/contribution_pages/posting.dart';
import 'package:sabai_app/screens/contribution_pages/upload_photo_page.dart';
import 'package:sabai_app/services/job_provider.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationHomepage extends StatefulWidget {
  final bool showButtonSheet;
  const NavigationHomepage({
    super.key,
    this.showButtonSheet = false,
  });

  @override
  State<NavigationHomepage> createState() => _NavigationHomepageState();
}

class _NavigationHomepageState extends State<NavigationHomepage> {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;
  final PageController _pageController = PageController();
  int _currentPage = 0;
  void whenUploadPhotoOnTap() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    setState(() {
      _currentPage++;
    });
  }

  late List<Widget> widgetList;
  int currentIndex = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widgetList = [
      const Community(),
      const Placeholder(),
      JobListingPage(
        showBottomSheet: widget.showButtonSheet,
      ),
      const SaveJobs(),
      const Profile(),
    ];
  }

  Future<String?> getUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('url');
  }

  Future<String?> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('location');
  }

  Future<bool?> getIsLocated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLocated');
  }

  Future<void> onTabChange(index, JobProvider jobProvider) async {
    if (index == 1) {
      if (jobProvider.isDraft == true) {
        String? url = await getUrl();
        String? location = await getLocation();
        bool? isLocated = await getIsLocated();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Posting(
              url: url,
              location: location,
              isLocated: isLocated,
            ),
          ),
        );
      } else {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled:
              true, // Ensures the bottom sheet adjusts to keyboard
          builder: (context) {
            return DraggableScrollableSheet(
              initialChildSize: 0.8,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context)
                        .viewInsets
                        .bottom, // Adjust padding
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ContributePage(
                        whenUploadPhotoOnTap: whenUploadPhotoOnTap,
                      ),
                      UploadPhotoPage(
                        whenCameraIsCalled: _initCamera,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      }
    } else {
      setState(() {
        currentIndex = index;
      });
    }
  }

  Future<void> _initCamera() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.low,
      );

      try {
        await cameraController!.initialize();
        if (mounted) {
          // After camera is initialized, navigate to camera preview
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CameraPreviewScreen(
                cameraController: cameraController!,
              ),
            ),
          );
        }
      } catch (e) {
        print('Error initializing camera: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var jobProvider = Provider.of<JobProvider>(context);
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 90,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          backgroundColor: const Color(0xffF7F7F7),
          selectedItemColor: const Color(0xffFF3997),
          selectedLabelStyle: languageProvider.lan == 'English'
              ? const TextStyle(
                  fontFamily: 'Bricolage-R',
                  fontSize: 12.5,
                )
              : const TextStyle(
                  fontFamily: 'Walone-B',
                  fontSize: 11,
                ),
          unselectedLabelStyle: languageProvider.lan == 'English'
              ? const TextStyle(
                  fontFamily: 'Bricolage-R',
                  fontSize: 12,
                )
              : const TextStyle(
                  fontFamily: 'Walone-B',
                  fontSize: 10,
                ),
          type: BottomNavigationBarType.fixed,
          //onTap: onTabChange,
          onTap: (value) {
            onTabChange(value, jobProvider);
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.apartment),
              label:
                  languageProvider.lan == 'English' ? 'Community' : 'အလုပ်ရှာ',
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.add_circled),
              label:
                  languageProvider.lan == 'English' ? 'Contribute' : 'အလုပ်တင်',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.work_outline_outlined),
              label: languageProvider.lan == 'English' ? 'Jobs' : 'အလုပ်ရှာ',
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.heart),
              label: languageProvider.lan == 'English'
                  ? 'Saved'
                  : 'သိမ်းထားသည်များ',
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.profile_circled),
              label: languageProvider.lan == 'English' ? 'Me' : 'ပရိုဖိုင်',
            ),
          ],
        ),
      ),
      body: widgetList[currentIndex],
    );
  }
}

class CameraPreviewScreen extends StatelessWidget {
  final CameraController cameraController;

  const CameraPreviewScreen({
    super.key,
    required this.cameraController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Adjust the CameraPreview to fit screen
              Center(
                child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: CameraPreview(cameraController),
                ),
              ),

              // Capture Button and Gradient Overlay
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        try {
                          final XFile photo =
                              await cameraController.takePicture();
                          if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Posting(
                                  url: photo.path,
                                ),
                              ),
                            );
                          }
                        } catch (e) {
                          print('Error taking picture: $e');
                        }
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                            width: 4,
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 36,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Positioned.fill(
              //   child: Container(
              //     decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //         colors: [
              //           Colors.black.withOpacity(0.6),
              //           Colors.transparent,
              //           Colors.black.withOpacity(0.6),
              //         ],
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }
}
