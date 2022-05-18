import 'package:injectable/injectable.dart';
import 'package:shortly/data/result.dart';
import 'package:shortly/data/model/short_url.dart';
import 'package:shortly/feature/history/data/repository/short_url_history_repository.dart';
import 'package:shortly/feature/shorten/data/repository/shorten_repository.dart';

@injectable
class DeleteShortUrlUseCase {
  final ShortUrlHistoryRepository/*!*/ shortUrlHistoryRepository;

  DeleteShortUrlUseCase(this.shortUrlHistoryRepository);

  Future<void> call(ShortUrl shortUrl) {
    return shortUrlHistoryRepository.deleteShortUrl(shortUrl);
  }
}
