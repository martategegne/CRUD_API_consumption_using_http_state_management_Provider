class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'],
    email: json['email'] ?? '',
    firstName: json['first_name'] ?? json['firstName'] ?? '',
    lastName: json['last_name'] ?? json['lastName'] ?? '',
    avatar: json['avatar'] ?? json['image'] ?? '',
  );
}

  Map<String, dynamic> toJson() {
    return {
      "name": "$firstName $lastName",
      "job": email,
    };
  }
}