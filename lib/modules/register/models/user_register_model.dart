class UserRegisterModel {
  String username;
  String firstName;
  String lastName;
  String roles;
  String tokenDevice;
  String profileRef;
  String password;
  UserRegisterModel({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.roles,
    required this.tokenDevice,
    required this.profileRef,
    required this.password,
  });

  UserRegisterModel copyWith({
    String? username,
    String? firstName,
    String? lastName,
    String? roles,
    String? tokenDevice,
    String? profileRef,
    String? password,
  }) {
    return UserRegisterModel(
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      roles: roles ?? this.roles,
      tokenDevice: tokenDevice ?? this.tokenDevice,
      profileRef: profileRef ?? this.profileRef,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'roles': roles,
      'tokenDevice': tokenDevice,
      'profileRef': profileRef,
      'password': password,
    };
  }

  factory UserRegisterModel.fromMap(Map<String, dynamic> map) {
    return UserRegisterModel(
      username: map['username'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      roles: map['roles'],
      tokenDevice: map['tokenDevice'],
      profileRef: map['profileRef'],
      password: map['password'],
    );
  }
}
