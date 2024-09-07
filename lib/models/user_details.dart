class UserDetails {
  final String email;
  final List<String> eventsList;

  const UserDetails({
    required this.email,
    required this.eventsList,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      eventsList: json['eventsList'] ?? [],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'eventsList': eventsList, 'email': email};
  }
}
