class User {
  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
    required this.role,
    required this.uerPoints,
    required this.userNotification,
  });
  late final String userId;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String imageUrl;
  late final String role;
  late final int uerPoints;
  late final List<dynamic> userNotification;

  User.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    userId = data['userId'];
    firstName = data['firstName'];
    lastName = data['lastName'];
    email = data['email'];
    imageUrl = data['imageUrl'];
    uerPoints = data['UserPoints'] ?? 0;
    userNotification = data['UserNotification'] != null
        ? List.castFrom<dynamic, dynamic>(data['UserNotification'])
        : [];
  }
}
