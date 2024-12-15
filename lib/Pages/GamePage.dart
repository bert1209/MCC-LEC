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
    return Scaffold(
      backgroundColor: const Color(0xFF000025),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/homePage');
          },
        ),
        backgroundColor: const Color(0xFF000025),
        title: Text(
          game?.title ?? 'Game Details',
          style: const TextStyle(fontFamily: "Gotham", color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : game != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(game!.image),
                      const SizedBox(height: 16),
                      Text(
                        game!.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Gotham",
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Genre: ${game!.genre}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Gotham",
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Platform: ${game!.platform}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Gotham",
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Release Date: ${game!.release_date}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Gotham",
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Publisher: ${game!.publisher}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Gotham",
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Developer: ${game!.developer}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Gotham",
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Description: ${game!.description}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Gotham",
                            color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Minimum System Requirements:",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Gotham",
                            color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      game!.minimum_system_requirements.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  game!.minimum_system_requirements.entries
                                      .map(
                                        (entry) => Text(
                                          "${entry.key}: ${entry.value}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Gotham",
                                              color: Colors.white),
                                        ),
                                      )
                                      .toList(),
                            )
                          : const Text(
                              "No system requirements available.",
                              style: TextStyle(fontSize: 16),
                            ),
                    ],
                  ),
                )
              : const Center(child: Text('No game details available')),
    );
  }
}
