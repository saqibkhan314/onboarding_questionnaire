// class Experience {
//   final int id;
//   final String name;
//   final String tagline;
//   final String description;
//   final String imageUrl;
//   final String iconUrl;

//   Experience({
//     required this.id,
//     required this.name,
//     required this.tagline,
//     required this.description,
//     required this.imageUrl,
//     required this.iconUrl,
//   });

//   factory Experience.fromJson(Map<String, dynamic> json) {
//     return Experience(
//       id: json['id'],
//       name: json['name'],
//       tagline: json['tagline'],
//       description: json['description'],
//       imageUrl: json['image_url'],
//       iconUrl: json['icon_url'],
//     );
//   }
// }









class Experience {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final String imageUrl;
  final String iconUrl;

  Experience({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.imageUrl,
    required this.iconUrl,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'],
      name: json['name'],
      tagline: json['tagline'],
      description: json['description'],
      imageUrl: json['image_url'],
      iconUrl: json['icon_url'],
    );
  }
}

// class ExperienceResponse {
//   final String message;
//   final List<Experience> experiences;

//   ExperienceResponse({
//     required this.message,
//     required this.experiences,
//   });

//   factory ExperienceResponse.fromJson(Map<String, dynamic> json) {
//     var experiencesList = json['data']['experiences'] as List;
//     List<Experience> experiences = experiencesList
//         .map((experience) => Experience.fromJson(experience))
//         .toList();

//     return ExperienceResponse(
//       message: json['message'],
//       experiences: experiences,
//     );
//   }
// }