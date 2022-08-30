class User {
  final String? name;
  final String? username;
  final String? email;
  final String? description;
  final String? profilePhotoUrl;
  final int? phoneNumber;
  final String? idEsplai;

  User({
    this.name,
    this.username,
    this.email,
    this.description,
    this.profilePhotoUrl,
    this.phoneNumber,
    this.idEsplai,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'username': username,
        'email': email,
        'description': description,
        'profilePhotoUrl': profilePhotoUrl,
        'idEsplai': idEsplai,
        'phoneNumber': phoneNumber
      };
}
