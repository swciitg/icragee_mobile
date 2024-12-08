class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String timestamp;
  final String creatorName;
  final String creatorId;
  final bool important;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.creatorName,
    required this.creatorId,
    required this.important,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      timestamp: json['timestamp'],
      creatorName: json['creatorName'],
      creatorId: json['creatorId'],
      important: json['important'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'timestamp': timestamp,
      'creatorName': creatorName,
      'creatorId': creatorId,
      'important': important,
    };
  }
}
