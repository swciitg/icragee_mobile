class EmergencyContact {
  final String name;
  final String phone;
  final String category;

  EmergencyContact(
      {required this.name, required this.phone, required this.category});

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      name: json['name'],
      phone: json['phone'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'category': category,
    };
  }
}
