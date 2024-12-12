import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sabai_app/components/bottom_sheet.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    // Show the bottom sheet automatically after the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => const Bottomsheet(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0F1F2),
      appBar: AppBar(
        title: const Text(
          "Jobs",
          style: TextStyle(
            fontFamily: 'Bricolage-M',
            fontSize: 19.53,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.bell,
              color: Color(0xffFF3997),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // Height of the bottom border
          child: Container(
            color: Colors.grey, // Border color
            height: 1.0, // Border thickness
          ),
        ),
        backgroundColor: const Color(0xffF0F1F2),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'images/motivation.png',
                  width: 28,
                  height: 28,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  '"Hard work pays off. Keep striving, and the right job\nwill come."',
                  style: TextStyle(
                    fontFamily: 'Bricolage-M',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  width: 295,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: SearchAnchor(
                    builder:
                        (BuildContext context, SearchController controller) {
                      return SearchBar(
                        backgroundColor: const WidgetStatePropertyAll<Color>(
                          Colors.white,
                        ),
                        controller: controller,
                        padding: const WidgetStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 16.0)),
                        onTap: () {
                          controller.openView();
                        },
                        onChanged: (_) {
                          controller.openView();
                        },
                        leading: const Icon(
                          Icons.search,
                          color: Colors.pink,
                        ),
                      );
                    },
                    suggestionsBuilder:
                        (BuildContext context, SearchController controller) {
                      return List<ListTile>.generate(5, (int index) {
                        final String item = 'item $index';
                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            setState(() {
                              controller.closeView(item);
                            });
                          },
                        );
                      });
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
