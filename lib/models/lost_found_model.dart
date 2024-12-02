class LostFoundModel {
  final String id;
  final String category;
  final String title;
  final String description;
  final String location;
  final String contact;
  final String imageUrl;
  final String name;
  final String email;
  final String submittedAt;
  final String submittedBy;

  LostFoundModel({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.location,
    required this.contact,
    required this.imageUrl,
    required this.name,
    required this.email,
    required this.submittedAt,
    required this.submittedBy,
  });

  factory LostFoundModel.fromJson(Map<String, dynamic> json) {
    return LostFoundModel(
      id: json['id'] ?? "",
      category: json['category'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      contact: json['contact'],
      imageUrl: json['image'],
      name: json['name'],
      email: json['email'],
      submittedAt: json['submittedAt'],
      submittedBy: json['submittedBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'description': description,
      'location': location,
      'contact': contact,
      'image': imageUrl,
      'name': name,
      'email': email,
      'submittedAt': submittedAt,
      'submittedBy': submittedBy,
    };
  }

  LostFoundModel copyWith({
    String? id,
    String? category,
    String? title,
    String? description,
    String? location,
    String? contact,
    String? image,
    String? name,
    String? email,
    String? submittedAt,
    String? submittedBy,
  }) {
    return LostFoundModel(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      contact: contact ?? this.contact,
      imageUrl: image ?? this.imageUrl,
      name: name ?? this.name,
      email: email ?? this.email,
      submittedAt: submittedAt ?? this.submittedAt,
      submittedBy: submittedBy ?? this.submittedBy,
    );
  }
}
