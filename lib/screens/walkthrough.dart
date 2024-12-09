import 'package:flutter/material.dart';

class Walkthrough extends StatefulWidget {
  const Walkthrough({super.key});

  @override
  State<Walkthrough> createState() => _WalkthroughState();
}

var dropdownValue = 'English';

class _WalkthroughState extends State<Walkthrough> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Container(
                        color: Colors.white,
                        width: 120,
                        height: 26,
                        child: Center(
                          child: DropdownButton<String>(
                            menuWidth: 130,
                            alignment: Alignment.center,
                            underline: Container(),
                            isExpanded: false,
                            value: dropdownValue,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                            ),
                            iconSize: 18,
                            items: [
                              DropdownMenuItem<String>(
                                alignment: Alignment.center,
                                value: 'English',
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 16,
                                      child: Image.asset('lib/icons/uk.png'),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text('English'),
                                  ],
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Myanmar',
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 16,
                                      child:
                                          Image.asset('lib/icons/myanmar.png'),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text('Myanmar'),
                                  ],
                                ),
                              ),
                            ],
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
