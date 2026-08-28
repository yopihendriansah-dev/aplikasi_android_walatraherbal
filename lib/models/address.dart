class Address {
  final String id;
  final String label;
  final String recipientName;
  final String phone;
  final String fullAddress;
  final bool isDefault;

  const Address({
    required this.id,
    required this.label,
    required this.recipientName,
    required this.phone,
    required this.fullAddress,
    this.isDefault = false,
  });

  Address copyWith({
    String? label,
    String? recipientName,
    String? phone,
    String? fullAddress,
    bool? isDefault,
  }) {
    return Address(
      id: id,
      label: label ?? this.label,
      recipientName: recipientName ?? this.recipientName,
      phone: phone ?? this.phone,
      fullAddress: fullAddress ?? this.fullAddress,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'recipientName': recipientName,
      'pohone': phone,
      'fullAddress': fullAddress,
      'isDefault': isDefault,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] as String,
      label: json['label'] as String,
      recipientName: json['recipentName'] as String,
      phone: json['phone'] as String,
      fullAddress: json['fullAddress'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }
}
