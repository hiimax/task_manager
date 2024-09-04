class UserModel {
  String? fullName, created, email, uuid, updated;

  // Constructor with optional 'id' parameter
  UserModel({
    this.fullName,
    this.created,
    this.email,
    this.uuid,
    this.updated,
  });

  // columns in the database.
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'],
      created: map['created'],
      email: map['email'],
      uuid: map['uuid'],
      updated: map['updated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'created': created,
      'email': email,
      'uuid': uuid,
      'updated': updated,
    };
  }
}
