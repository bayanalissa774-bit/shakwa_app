class GovernmentEntity {
  final int id;
  final String name;
  final String description;
  final String? icon; // رابط الأيقونة أو الصورة إن وجدت

  const GovernmentEntity({
    required this.id,
    required this.name,
    required this.description,
    this.icon,
  });
}
