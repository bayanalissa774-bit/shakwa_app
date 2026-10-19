class NewsEntity {
  final int id;
  final String title;
  final String subtitle;
  final String content;
  final String image;
  final String tag;
  final String time;

  const NewsEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.image,
    required this.tag,
    required this.time,
  });
}
