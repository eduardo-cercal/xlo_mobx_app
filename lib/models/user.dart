enum UserType { particular, professional }

class User {
  String name;
  String? email;
  String phone;
  String? pass;
  UserType type;
  String? id;
  DateTime? createdAt;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.pass,
    this.type = UserType.particular,
    this.createdAt,
  });

  @override
  String toString() {
    return 'User{name: $name, email: $email, phone: $phone, pass: $pass, type: $type, id: $id, createdAt: $createdAt}';
  }
}
