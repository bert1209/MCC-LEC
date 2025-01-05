import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xFF000025),
        leading: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF00008B),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.fromLTRB(16, 20, 0, 20),
          child: IconButton(
            color: const Color(0xFFEFEFEF),
            onPressed: () {
              Navigator.pushNamed(context, '/aboutProfilePage');
            },
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: const Text(
            'About',
            style: TextStyle(
                fontFamily: "poppins", color: Color(0xFFEFEFEF), fontSize: 20),
          ),
        ),
      ),

      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: screenWidth * 1,
              height: screenHeight * 0.6,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF000025), Color(0xFF000058)], // Start and end colors for the gradient
                  begin: Alignment.topCenter, // Start position of the gradient
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.015,),

                    Text(
                      "Game Box V0.01",
                      style: const TextStyle(
                          fontSize: 24,
                          fontFamily: "poppins",
                          color: Colors.white),
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
                            text: "     2025-01-05",
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 16,
                              color: Colors.grey.shade200, // White color for 'Store'
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.035,),

                    Text(
                      "Created by:",
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: "gotham",
                          color: Colors.grey.shade500
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.015,),

                    Row(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Add border radius
                            child: Image.asset(
                              'lib/Assets/delbert.jpg',
                              fit: BoxFit.cover, // Adjusts the image to cover the container
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03), // Adds space between the image and the text
                        Expanded( // Allows text to take up available space and prevents overflow
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the left
                            children: [
                              Text(
                                "Delbert Melvin Setioso",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: "poppins",
                                    color: Colors.white),
                              ),

                              SizedBox(height: 5,),
                              Text(
                                "- A passionate programmer committed to continuous learning and embracing challenges to grow in the ever-evolving tech world.",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "gotham",
                                    color: Colors.grey.shade500,
                                    height: 1.2
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.02,),

                    Row(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Add border radius
                            child: Image.asset(
                              'lib/Assets/rayden.jpg',
                              fit: BoxFit.cover, // Adjusts the image to cover the container
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03), // Adds space between the image and the text
                        Expanded( // Allows text to take up available space and prevents overflow
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the left
                            children: [
                              Text(
                                "Rayden Blezworth Arwan",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: "poppins",
                                    color: Colors.white),
                              ),

                              SizedBox(height: 5,),
                              Text(
                                "- An enthusiastic programmer dedicated to constant learning and tackling challenges to advance in the ever-changing tech landscape.",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "gotham",
                                    color: Colors.grey.shade500,
                                    height: 1.2
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Container(
              width: screenWidth * 1,
              height: screenHeight * 0.3,
              color: Color(0xFF00008B),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.045),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      '" Find the games. Share the journey. "',
                      style: TextStyle(
                        color: Colors.grey.shade200,
                        fontFamily: 'poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center, // Optional for ensuring text alignment
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.025),

                  Row(
                    children: [
                      SizedBox(width: screenWidth * 0.05),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Add your action here, e.g., open Facebook
                            },
                            child: Container(
                              height: 33,
                              width: 33,
                              decoration: BoxDecoration(
                                color: Color(0xFFEFEFEF),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              child: Icon(
                                Icons.facebook,
                                color: Color(0xFF000000),
                                size: 25,
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.018),
                          GestureDetector(
                            onTap: () {
                              // Add your action here, e.g., open WhatsApp
                            },
                            child: Container(
                              height: 33,
                              width: 33,
                              decoration: BoxDecoration(
                                color: Color(0xFFEFEFEF),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              child: Image.asset(
                                "lib/Assets/Whatsapp.png",
                                width: 20, // Adjusted to fit within the container
                                height: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.018),
                          GestureDetector(
                            onTap: () {
                              // Add your action here, e.g., open Instagram
                            },
                            child: Container(
                              height: 33,
                              width: 33,
                              decoration: BoxDecoration(
                                color: Color(0xFFEFEFEF),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              child: Image.asset(
                                "lib/Assets/instagram.png",
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
