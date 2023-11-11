class User {
  String? uId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;

  User({
    this.uId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
  });

  User.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
    };
  }
}
