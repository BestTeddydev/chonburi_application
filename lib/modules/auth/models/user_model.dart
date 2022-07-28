class UserModel {
  String userId;
  String username;
  String firstName;
  String lastName;
  String roles;
  String token;
  String tokenDevice;
  String profileRef;
  UserModel({
    required this.userId,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.roles,
    required this.token,
    required this.tokenDevice,
    required this.profileRef,
  });

  UserModel copyWith({
    String? userId,
    String? username,
    String? firstName,
    String? lastName,
    String? roles,
    String? token,
    String? tokenDevice,
    String? profileRef,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      roles: roles ?? this.roles,
      token: token ?? this.token,
      tokenDevice: tokenDevice ?? this.tokenDevice,
      profileRef: profileRef ?? this.profileRef,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'roles': roles,
      'token': token,
      'tokenDevice': tokenDevice,
      'profileRef':profileRef,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      username: map['username'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      roles: map['roles'] ?? '',
      token: map['token'] ?? '',
      tokenDevice: map['tokenDevice'] ?? '',
      profileRef: map['profileRef'] ?? '',
    );
  }
}
