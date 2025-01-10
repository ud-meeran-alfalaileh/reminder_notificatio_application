class UserModel {
  final int userId;
  final String email;
  final String firstName;
  final String sectName;
  final String password;

  UserModel({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.sectName,
    required this.password,
  });

  // Factory constructor to create a UserModel instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      email: json['email'],
      firstName: json['firstName']??'',
      sectName: json['sectName']??'',
      password: json['password'],
    );
  }

  // Method to convert a UserModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'firstName': firstName,
      'sectName': sectName,
      'password': password,
    };
  }
}
