import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcc_final/Pages/GamePage.dart';
import '../Auth/auth.dart';
import '../Function/Module.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<games> gamesList = [];
  List<games> filteredGamesList = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  Future<void> fetchGames() async {
    try {
      var response = await http.get(Uri.https('freetogame.com', 'api/games'));
      var jsonData = jsonDecode(response.body);
      for (var eachGame in jsonData) {
        final game = games(
          id: eachGame['id'],
          title: eachGame['title'],
          image: eachGame['thumbnail'],
          description: eachGame['short_description'],
          genre: eachGame['genre'],
          platform: eachGame['platform'],
          release_date: eachGame['release_date'],
          publisher: eachGame['publisher'],
          developer: eachGame['developer'],
          minimum_system_requirements: eachGame['minimum_system_requirements'],
        );
        gamesList.add(game);
      }
      filteredGamesList = gamesList;
    } catch (e) {
      print("Error fetching games: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterGames(String query) {
    List<games> tempGamesList = [];
    for (var game in gamesList) {
      if (game.title.toLowerCase().contains(query.toLowerCase())) {
        tempGamesList.add(game);
      }
    }
    setState(() {
      filteredGamesList = tempGamesList;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0000025),
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
              Navigator.pushNamed(context, "/aboutProfilePage");
            },
            icon: const Icon(Icons.person),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.only(
            top: 11,
          ),
          width: 375,
          height: 70,
          child: TextField(
            controller: searchController,
            style: TextStyle(
              fontFamily: 'poppins',
              fontSize: 18,         // Set font size
              color: Colors.grey.shade800,  // Set text color
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(

                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              fillColor: const Color(0xFFFFFFFF),
              filled: true,
              hintText: "Search",
              hintStyle: TextStyle(
                fontFamily: 'poppins',
                fontSize: 18,         // Font size for hint text
                color: Colors.grey,   // Color for hint text
              ),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                icon: Icon(Icons.clear),
                color: Colors.grey,
                onPressed: () {
                  searchController.clear(); // Clear the input field
                  filterGames('');         // Reset the filter
                },
              )
                  : Icon(
                Icons.search, // Default search icon
                color: Colors.grey,
              ),
            ),
            onChanged: (value) {
              filterGames(value);
            },
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredGamesList.length,
              itemBuilder: (context, index) {
                final game = filteredGamesList[index];
                return GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/gamePage');
                    var navigator = Navigator.of(context);
                    navigator.push(
                      MaterialPageRoute(
                        builder: (builder) {
                          return GamePage(
                            GameID: game.id.toString(),
                          );
                        },
                      ),
                    );
                  },


                  child: Padding(
                    padding: const EdgeInsets.all(5), // Keeps the vertical space between cards
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0), // Add border radius
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF00008B), Color(0xFF000058)], // Define gradient colors
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                          borderRadius: BorderRadius.circular(5.0), // Match the Card's border radius
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                              ),
                              child: Image.network(
                                game.image,
                                fit: BoxFit.cover,
                                height: 150,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 5),
                              child: AutoSizeText(
                                game.title,
                                style: TextStyle(
                                  fontFamily: "poppins",
                                  fontSize: 16,
                                  color: Colors.white,
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                minFontSize: 16, // Reduce the font size if necessary
                                overflow: TextOverflow.ellipsis, // Truncate text if it's too long
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: AutoSizeText(
                                "Genre : ${game.genre}",
                                style: TextStyle(
                                  fontFamily: "gotham",
                                  fontSize: 14,
                                  color: Colors.grey.shade300,
                                ),
                                maxLines: 1,
                                minFontSize: 14, // Reduce the font size if necessary
                                overflow: TextOverflow.ellipsis, // Truncate text if it's too long
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ),
                );
              },
            ),
    );
  }
}
