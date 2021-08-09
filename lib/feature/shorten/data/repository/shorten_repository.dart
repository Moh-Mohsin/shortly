import 'package:injectable/injectable.dart';
import 'package:shortly/data/db/database.dart';
import 'package:shortly/data/exceptions/exceptions.dart';
import 'package:shortly/data/model/short_url.dart';
import 'package:shortly/data/result.dart';
import 'package:shortly/feature/shorten/data/source/shorten_remote_data_source.dart';

abstract class ShortenRepository {
  Future<Result<ShortUrl>> shortenUrl(String url);
}

@Singleton(as: ShortenRepository)
class ShortenRepositoryImpl extends ShortenRepository {
  final ShortenRemoteDataSource shortenRemoteDataSource;
  final AppDatabase appDatabase;

  ShortenRepositoryImpl(this.shortenRemoteDataSource, this.appDatabase);

  @override
  Future<Result<ShortUrl>> shortenUrl(String url) async {
    try {
      final response = await shortenRemoteDataSource.shortenUrl(url);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final shortUrl = response.result.mapToShortUrl(timestamp);
      appDatabase.shortUrlDao.insertShortUrl(shortUrl);
      return Success(shortUrl);
    } on AppException catch (e) {
      return Error<ShortUrl>(e);
    }
  }

}