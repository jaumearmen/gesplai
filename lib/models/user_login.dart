class UserLogin {
  final String? uid;
  final String? email;

  UserLogin(
    this.uid,
    this.email,
  );

  String? getEmail() {
    return email;
  }
}
