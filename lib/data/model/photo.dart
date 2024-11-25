class Photo {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String fullImageUrl;

  Photo({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.fullImageUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      title: json['alt_description'] ?? 'Sin título',
      thumbnailUrl: json['urls']['thumb'],
      fullImageUrl: json['urls']['full'],
    );
  }
}
