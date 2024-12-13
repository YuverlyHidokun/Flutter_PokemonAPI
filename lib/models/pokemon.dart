class Pokemon {
  final String name;
  final int id;
  final int height;
  final int weight;
  final String imageUrl;

  Pokemon({
    required this.name,
    required this.id,
    required this.height,
    required this.weight,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      id: json['id'],
      height: json['height'],
      weight: json['weight'],
      imageUrl: json['sprites']['front_default'],
    );
  }
}
