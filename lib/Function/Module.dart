class games {
  final int id;
  final String title;
  final String image;
  final String description;
  final String genre;
  final String platform;
  final String release_date;
  final String publisher;
  final String developer;
  final String? minimum_system_requirements;

  games({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.genre,
    required this.platform,
    required this.release_date,
    required this.publisher,
    required this.developer,
    required this.minimum_system_requirements,
  });
}

class gamess {
  final String id;
  final String title;
  final String image;
  final String description;
  final String genre;
  final String platform;
  final String release_date;
  final String publisher;
  final String developer;
  final Map<String, dynamic> minimum_system_requirements;

  gamess({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.genre,
    required this.platform,
    required this.release_date,
    required this.publisher,
    required this.developer,
    required this.minimum_system_requirements,
  });
}
