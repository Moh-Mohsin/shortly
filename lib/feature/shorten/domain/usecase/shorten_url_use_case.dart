import 'package:injectable/injectable.dart';
import 'package:shortly/data/result.dart';
import 'package:shortly/data/model/short_url.dart';
import 'package:shortly/feature/shorten/data/repository/shorten_repository.dart';

@injectable
class ShortenUrlUseCase {
  final ShortenRepository shortenRepository;

  ShortenUrlUseCase(this.shortenRepository);

  Future<Result<ShortUrl>> call(String url) async {
    return shortenRepository.shortenUrl(url);
  }
}
