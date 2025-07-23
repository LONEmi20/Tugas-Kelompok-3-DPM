class User {
  final String name;
  final String noHp;
  final String email;
  final String password;
  String profilePicture; 

  User({
    required this.name,
    required this.noHp,
    required this.email,
    required this.password,
    this.profilePicture = '', 
  });

  // ngubah dari JSON ke object User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      noHp: json['noHp'],
      email: json['email'],
      password: json['password'],
      profilePicture: json['profilePicture'] ?? '',
    );
  }

  // ngubah data user baru ke JSON 
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
