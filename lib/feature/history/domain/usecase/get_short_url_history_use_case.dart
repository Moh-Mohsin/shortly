import 'package:injectable/injectable.dart';
import 'package:shortly/data/result.dart';
import 'package:shortly/data/model/short_url.dart';
import 'package:shortly/feature/history/data/repository/short_url_history_repository.dart';
import 'package:shortly/feature/shorten/data/repository/shorten_repository.dart';

@injectable
class GetShortUrlHistoryUseCase {
  final ShortUrlHistoryRepository shortUrlHistoryRepository;

  GetShortUrlHistoryUseCase(this.shortUrlHistoryRepository);

  Stream<List<ShortUrl>> call() {
    return shortUrlHistoryRepository.getAllShortUrls();
  }
}
