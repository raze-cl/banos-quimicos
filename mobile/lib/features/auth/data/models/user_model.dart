class UserModel {
  final String id;
  final String email;
  final String role;
  final String tenantId;

  UserModel({
    required this.id,
    required this.email,
    required this.role,
    required this.tenantId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      tenantId: json['tenantId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
      'tenantId': tenantId,
    };
  }
}
