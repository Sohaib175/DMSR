class Category {
  final String name;
  final String image;

  Category({
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
      };

  static Category fromJson(Map<String, dynamic> json) =>
      Category(name: json['name'], image: json['image']);
}
