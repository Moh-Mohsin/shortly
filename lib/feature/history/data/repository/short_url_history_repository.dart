
import 'package:injectable/injectable.dart';
import 'package:shortly/data/db/database.dart';
import 'package:shortly/data/model/short_url.dart';

abstract class ShortUrlHistoryRepository{
  Stream<List<ShortUrl>> getAllShortUrls();

  Future<void> deleteShortUrl(ShortUrl shortUrl);
}

@Singleton(as: ShortUrlHistoryRepository)
class ShortUrlHistoryRepositoryImpl extends ShortUrlHistoryRepository{
  final AppDatabase appDatabase;

  ShortUrlHistoryRepositoryImpl(this.appDatabase);

  @override
  Stream<List<ShortUrl>> getAllShortUrls() {
    return appDatabase.shortUrlDao.findAllShortUrls();
  }

  @override
  Future<void> deleteShortUrl(ShortUrl shortUrl) {
    return appDatabase.shortUrlDao.deleteShortUrl(shortUrl);
  }


}
