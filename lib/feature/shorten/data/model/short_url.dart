
import 'package:shortly/data/network/response/shorten_response.dart';

class ShortUrl {
  final String fullShortLink;
  final String originalLink;

  ShortUrl(this.fullShortLink, this.originalLink);
}

extension DtoMapping on ShortenDto {
  ShortUrl mapToShortUrl() {
    return ShortUrl(this.fullShortLink, this.originalLink);
  }
}