class TryOnModel {
  final String id;
  final String status; // ex: "pending", "completed", "failed"
  final String? resultImageUrl;
  final DateTime createdAt;

  TryOnModel({
    required this.id,
    required this.status,
    this.resultImageUrl,
    required this.createdAt,
  });

  // Convertit le JSON renvoyé par Django en objet Dart
  factory TryOnModel.fromJson(Map<String, dynamic> json) {
    return TryOnModel(
      id: json['id'],
      status: json['status'],
      resultImageUrl: json['result_image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}