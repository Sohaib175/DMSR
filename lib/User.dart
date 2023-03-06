class Usermodal {
  String email;
  String name;
  String role;

  Usermodal({
    required this.email,
    required this.name,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'role': role,
      };

  static Usermodal fromJson(Map<String, dynamic> json) =>
      Usermodal(email: json['email'], name: json['name'], role: json['role']);
}
