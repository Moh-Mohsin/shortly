import 'package:floor/floor.dart';
import 'package:shortly/data/network/response/shorten_response.dart';

@entity
class ShortUrl {
  @primaryKey
  final String code;
  final String fullShortLink;
  final String originalLink;
  final int timestamp;

  ShortUrl(this.code, this.fullShortLink, this.originalLink, this.timestamp);
}

extension DtoMapping on ShortenDto {
  ShortUrl mapToShortUrl(int timestamp) {
    return ShortUrl(this.code, this.fullShortLink, this.originalLink, timestamp);
  }
}
