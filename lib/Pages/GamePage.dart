import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../Function/Module.dart';

class GamePage extends StatefulWidget {
  final String GameID;
  const GamePage({super.key, required this.GameID});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  gamess? game; // Nullable game object
  bool isLoading = true;

  Future<void> fetchGameDetails() async {
    try {
      var response = await http
          .get(Uri.https('freetogame.com', 'api/game', {'id': widget.GameID}));
      var jsonData = jsonDecode(response.body);

      // Handling a single game object
      game = gamess(
        id: jsonData['id'].toString(),
        title: jsonData['title'],
        image: jsonData['thumbnail'],
        description: jsonData['short_description'],
        genre: jsonData['genre'],
        platform: jsonData['platform'],
        release_date: jsonData['release_date'],
        publisher: jsonData['publisher'],
        developer: jsonData['developer'],
        minimum_system_requirements:
            jsonData['minimum_system_requirements'] ?? {},
      );
    } catch (e) {
      print("Error fetching game details: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGameDetails();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF000025),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xFF000025),
        leading: Container(
          decoration: BoxDecoration(
              color: const Color(0xFF00008B),
              borderRadius: BorderRadius.circular(10)),

          margin: const EdgeInsets.fromLTRB(
              16, 20, 0, 20), // Adds 16px space on the left
          child: IconButton(
            color: const Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.pushNamed(context, '/homePage');
            },
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            game?.title ?? 'Game Details',
            style: const TextStyle(fontFamily: "poppins", color: Colors.white, fontSize: 24),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : game != null
              ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF000025), Color(0xFF000058)], // Start and end colors for the gradient
                          begin: Alignment.topCenter, // Start position of the gradient
                          end: Alignment.bottomCenter, // End position of the gradient
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Image.network(game!.image,),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Text(
                              game!.title,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontFamily: "poppins",
                                color: Colors.white,
                                height: 1.2
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Developer',
                                    style: TextStyle(
                                      fontFamily: 'gotham',
                                      fontSize: 16,
                                      color: Colors.grey.shade500, // Original color for 'Banboo'
                                    ),
                                  ),
                                  TextSpan(
                                    text: "   ${game!.developer}",
                                    style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 16,
                                      color: Colors.grey.shade200, // White color for 'Store'
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Publisher',
                                    style: TextStyle(
                                      fontFamily: 'gotham',
                                      fontSize: 16,
                                      color: Colors.grey.shade500, // Original color for 'Banboo'
                                    ),
                                  ),
                                  TextSpan(
                                    text: "     ${game!.publisher}",
                                    style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 16,
                                      color: Colors.grey.shade200, // White color for 'Store'
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Released',
                                    style: TextStyle(
                                      fontFamily: 'gotham',
                                      fontSize: 16,
                                      color: Colors.grey.shade500, // Original color for 'Banboo'
                                    ),
                                  ),
                                  TextSpan(
                                    text: "     ${game!.release_date}",
                                    style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 16,
                                      color: Colors.grey.shade200, // White color for 'Store'
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            Text(
                              "${game!.description}",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "gotham",
                                  color: Colors.grey.shade200),
                            ),

                            SizedBox(height: screenHeight * 0.03),

                            Text(
                              "Genre",
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontFamily: "gotham",
                                  color: Colors.white),
                            ),
                            SizedBox(height: screenHeight * 0.005),

                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF0000BE),
                                borderRadius: BorderRadius.circular(8)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 12, 10, 8),
                                child: Text(
                                  "${game!.genre}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "gotham",
                                      color: Colors.grey.shade200
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.03),

                            const Text(
                              "System Requirements",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: "gotham",
                                  color: Colors.white),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Text(
                              "MINIMUM:",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "gotham",
                                  color: Colors.grey.shade200),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            game!.minimum_system_requirements.isNotEmpty
                                ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                              game!.minimum_system_requirements.entries
                                  .map(
                                    (entry) => Text(
                                  "${entry.key}: ${entry.value}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "poppins",
                                      color: Colors.grey.shade200),
                                ),
                              )
                                  .toList(),
                            )
                                : Text(
                              "No system requirements available.",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "poppins",
                                  color: Colors.grey.shade200),
                            ),
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              )
              : const Center(child: Text('No game details available')),
    );
  }
}
