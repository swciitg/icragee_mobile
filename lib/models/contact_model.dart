class ContactModel {
  final String name;
  final String phone;
  final String category;

  ContactModel({required this.name, required this.phone, required this.category});

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
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
