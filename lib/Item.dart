class Item {
  int? quantity;
  final String name;
  final String disc;
  final int? price;
  final String imageName;
  final String imageURL;
  String instruction;
  bool isAvailable;

  Item(
      {required this.quantity,
      required this.name,
      required this.disc,
      required this.price,
      required this.imageName,
      required this.imageURL,
      required this.instruction,
      required this.isAvailable});

  Map<String, dynamic> toJson() => {
        'name': name,
        'quantity': quantity,
        'description': disc,
        'price': price,
        'imageName': imageName,
        'imageURL': imageURL,
        'instruction': instruction,
        'isAvailable': isAvailable,
      };

  static Item fromJson(Map<String, dynamic> json) => Item(
      name: json['name'],
      quantity: json['quantity'],
      disc: json['description'],
      price: json['price'],
      imageName: json['imageName'],
      imageURL: json['imageURL'],
      instruction: json['instruction'],
      isAvailable: json['isAvailable']);
}
