import '../../domain/entities/news_entity.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_data_source.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<NewsEntity>> getNews() async {
    // جلب الـ NewsModel من الـ Data Source (لأن Model يرث من Entity، يمكننا إرجاعه مباشرة)
    final newsModels = await remoteDataSource.getNews();
    return newsModels;
  }
}
