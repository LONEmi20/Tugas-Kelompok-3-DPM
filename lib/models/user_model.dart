class User {
  String name;
  String noHp;
  String email;
  String profilePicture; 
  final String password;

  User({
    required this.name,
    required this.noHp,
    required this.email,
    required this.password,
    this.profilePicture = '', 
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      noHp: json['noHp'],
      email: json['email'],
      password: json['password'],
      profilePicture: json['profilePicture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'noHp': noHp,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
    };
  }
}
