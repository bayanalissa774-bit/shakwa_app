import '../entities/news_entity.dart';

abstract class NewsRepository {
  // دالة جلب قائمة الأخبار، تعيد Future يحتوي على قائمة من NewsEntity
  Future<List<NewsEntity>> getNews();
}
