class SignUpBody {
  int? id;
  String name;
  String phone;
  String email;
  String password;
  String role; 

  SignUpBody({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    this.role = 'client', 
  });

  factory SignUpBody.fromMap(Map<String, dynamic> map) {
    return SignUpBody(
      id: map['id'] as int?,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      role: map['role'] as String, 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'role': role, 
    };
  }
}
