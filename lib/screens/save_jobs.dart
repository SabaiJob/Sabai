import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/services/job_provider.dart';
import 'package:sabai_app/services/language_provider.dart';

import '../components/work_card.dart';

class SaveJobs extends StatefulWidget {
  const SaveJobs({super.key});

  @override
  State<SaveJobs> createState() => _SaveJobsState();
}

class _SaveJobsState extends State<SaveJobs> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var jobProvider = Provider.of<JobProvider>(context);
    List<String> savedJobs = jobProvider.savedJobs;

    final filterJobs = savedJobs.where((job) {
      bool matchesQuery = job.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesQuery;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        title: languageProvider.lan == 'English'
            ? const Text(
                "Saved Jobs",
                style: TextStyle(
                  fontFamily: 'Bricolage-M',
                  fontSize: 19.53,
                ),
              )
            : const Text(
                "သိမ်းထားသည့်အလုပ်များ",
                style: TextStyle(
                  fontFamily: 'Walone-B',
                  fontSize: 19.53,
                ),
              ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(1.0), // Height of the bottom border
          child: Container(
            color: Colors.grey.shade300, // Border color
            height: 1.0, // Border thickness
          ),
        ),
        backgroundColor: const Color(0xffF0F1F2),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 365,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: languageProvider.lan == 'English'
                        ? 'Search by keywords'
                        : 'ရှာဖွေမယ်',
                    hintStyle: languageProvider.lan == 'English'
                        ? GoogleFonts.dmSans(
                            textStyle: const TextStyle(
                              color: Color(0xff989EA4),
                              fontSize: 14,
                            ),
                          )
                        : const TextStyle(
                            fontFamily: 'Walone-R',
                            color: Color(0xff989EA4),
                            fontSize: 14,
                          ),
                    prefixIcon: IconButton(
                      icon: Icon(
                        // searchQuery.isEmpty &&
                        isSearching ? Icons.clear : Icons.search,
                        color: const Color(0xffFF3997),
                      ),
                      onPressed: () {
                        if (isSearching) {
                          FocusScope.of(context).unfocus();
                          // Clear the search query and reset search state
                          _searchController.clear();
                          setState(() {
                            searchQuery = ""; // Clear search query
                            isSearching = false; // Switch back to search icon
                          });
                        }
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xffF0F1F2),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color:
                            Color(0xffFF3997), // Border color when not focused
                        width: 1,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 17),
                  ),
                  onTap: () {
                    setState(() {
                      isSearching = true; // Activate search mode
                    });
                  },
                  onChanged: (val) {
                    setState(() {
                      searchQuery = val; // Update the search query
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (isSearching) ...[
              Expanded(
                  child: ListView.builder(
                      itemCount: filterJobs.length,
                      itemBuilder: (context, index) {
                        var jobs = filterJobs[index];
                        return ListTile(
                          title: Text(
                            jobs,
                            style: const TextStyle(
                              fontSize: 15.63,
                              fontFamily: 'Bricolage-M',
                            ),
                          ),
                        );
                      })),
            ] else ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Saved (${jobProvider.savedJobs.length}) jobs',
                    style: const TextStyle(
                      fontFamily: 'Bricolage-M',
                      fontSize: 15.63,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  color: const Color(0xffF7F7F7),
                  child: savedJobs.isNotEmpty
                      ? ListView.builder(
                          itemCount: savedJobs.length, // Total number of items
                          itemBuilder: (context, index) {
                            return WorkCard(
                              savedJobs[index],
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                            'There is no saved jobs',
                            style: TextStyle(
                              fontFamily: 'Bricolage',
                              fontSize: 15.42,
                            ),
                          ),
                        ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
