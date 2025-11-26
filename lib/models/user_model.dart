class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String phone;
  final String profession;
  final String photoUrl;
  final String role;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.profession,
    required this.photoUrl,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'profession': profession,
      'photoUrl': photoUrl,
      'role': role,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      profession: map['profession'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      role: map['role'] ?? 'user',
    );
  }
}
