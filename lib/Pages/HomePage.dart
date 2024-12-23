import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mcc_final/Pages/GamePage.dart';
import '../Auth/auth.dart';
import '../Function/Module.dart';

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
        backgroundColor: const Color(0xFF000025),
        leading: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFF00008B),
                borderRadius: BorderRadius.circular(15)),
            child: IconButton(
              color: const Color(0xFF333333),
              onPressed: () {
                Navigator.pushNamed(context, "/aboutProfilePage");
              },
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 5),
          child: SizedBox(
            width: 340,
            child: TextField(
              controller: searchController,
              style: const TextStyle(fontFamily: "Gotham", fontSize: 18),
              obscureText: false,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF777777),
                    ),
                    borderRadius: BorderRadius.circular(15)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF333333),
                    ),
                    borderRadius: BorderRadius.circular(15)),
                fillColor: const Color(0xFFFFFFFF),
                filled: true,
                hintText: "Search",
                contentPadding: const EdgeInsets.all(15),
              ),
              onChanged: (value) {
                filterGames(value);
              },
            ),
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
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      color: const Color(0xFF00008B),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            game.image,
                            fit: BoxFit.cover,
                            height: 170,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              game.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Gotham",
                                  color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Genre : ${game.genre}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white, fontFamily: "Gotham"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
