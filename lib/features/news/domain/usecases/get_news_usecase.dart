import '../entities/news_entity.dart';
import '../repositories/news_repository.dart';

class GetNewsUseCase {
  final NewsRepository repository;

  GetNewsUseCase(this.repository);

  // استخدام (callable class) لتنفيذ الـ UseCase مباشرة كأنها دالة
  Future<List<NewsEntity>> call() async {
    return await repository.getNews();
  }
}
