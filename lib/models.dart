
enum Gender { male, female }

enum SortType { az, rating, favorite, female, male }

class Doctor {
  final String id;
  final String name;
  final String specialty;
  final Gender gender;
  final double rating;
  final int reviews;
  final int experience;
  final String focus;
  final String schedule;
  final String profile;
  final String careerPath;
  final String highlights;
  final String imageUrl;
  final bool isFavorite;
  final bool isProfessional;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.gender,
    required this.rating,
    required this.reviews,
    required this.experience,
    required this.focus,
    required this.schedule,
    required this.profile,
    required this.careerPath,
    required this.highlights,
    required this.imageUrl,
    required this.isFavorite,
    this.isProfessional = true,
  });
}

class Service {
  final String id;
  final String title;
  final String description;

  Service({
    required this.id,
    required this.title,
    required this.description,
  });
}
