import '../../domain/entities/news_entity.dart';

class NewsModel extends NewsEntity {
  const NewsModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.content,
    required super.image,
    required super.tag,
    required super.time,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['news_number'] ?? json['id'] ?? 0,
      title: json['title_of_news']?.toString() ?? '',
      subtitle: json['news_text']?.toString() ?? '',
      content:
          json['news_text']?.toString() ??
          '', // استخدام نص الخبر كمحتوى إذا لم يوجد حقل مستقل
      image:
          json['news_image']?.toString() ??
          'assets/images/news_item_thumb (1).png',
      time: json['publish_date']?.toString() ?? '',
      tag: json['news_priority']?.toString() ?? 'عام',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title_of_news': title,
      'news_text': subtitle,
      'news_image': image,
      'publish_date': time,
      'news_priority': tag,
    };
  }
}
