import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sabai_app/constants.dart';

class AddLocation extends StatefulWidget {
  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  List<dynamic> _places = [];
  bool _isLoading = false;
  final _searchController = TextEditingController();

  Future<void> searchPlaces(String query) async {
    if (query.length < 3) return; // Don't search for very short queries

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
            'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(query)}&format=json&limit=10'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          _places = json.decode(response.body);
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Check In',
          style: appBarTitleStyleEng,
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: primaryPinkColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Bricolage-R',
                ),
                decoration: const InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Bricolage-R',
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: primaryPinkColor,
                    size: 25,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  isCollapsed: true,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(8),
                  // ),
                ),
                onChanged: (value) {
                  // Add debounce to avoid too many API calls
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (value == _searchController.text) {
                      searchPlaces(value);
                    }
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _places.length,
                  itemBuilder: (context, index) {
                    final place = _places[index];
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(
                            place['display_name'],
                            style: const TextStyle(
                              fontSize: 15.63,
                              fontFamily: 'Bricolage-R',
                            ),
                          ),
                          subtitle: Text(
                              'Lat: ${place['lat']}, Lon: ${place['lon']}'),
                          onTap: () {
                            Map<String, dynamic> locationData = {
                              'location': place['display_name'],
                              'isLocated':
                                  true // Set this to true when a location is selected
                            };
                            Navigator.pop(context, locationData);
                            // Handle location selection
                            print('Selected: ${place['display_name']}');
                            print(
                                'Coordinates: ${place['lat']}, ${place['lon']}');
                            // You can pass this data back to the parent widget
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
