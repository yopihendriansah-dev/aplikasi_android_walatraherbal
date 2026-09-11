class User {
  final String id;
  final String name;
  final String? email;
  final String phone;
  final DateTime? profileCompletedAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileCompletedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profile_completed_at': profileCompletedAt?.toIso8601String(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: '${json['id']}',
      name: json['name'] as String? ?? '',
      email: json['email'] as String?,
      phone: json['phone'] as String? ?? '',
      profileCompletedAt: json['profile_completed_at'] is String
          ? DateTime.tryParse(json['profile_completed_at'] as String)
          : null,
    );
  }
}
