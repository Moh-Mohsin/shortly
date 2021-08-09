import 'package:shortly/data/model/short_url.dart';
import 'package:shortly/data/network/response/shorten_response.dart';

class Dummy {
  static ShortUrl getShortUrl(String originalLink) {
    final shortenResponse = Dummy.getShortenResponse(originalLink);
    final int timestamp = 165413216;
    return shortenResponse.result.mapToShortUrl(timestamp);
  }

  static ShortenResponse getShortenResponse(String originalLink) {
    return ShortenResponse(
      ok: true,
      result: ShortenDto(
        code: "fnSy",
        fullShortLink: 'https://shrtco.de/fnSy',
        shareLink: 'shrtco.de/share/fnSy',
        fullShareLink: '',
        fullShortLink2: 'https://9qr.de/fnSy',
        shortLink2: '9qr.de/fnSy',
        shortLink: 'shrtco.de/fnSy',
        originalLink: originalLink,
      ),
    );
  }

  static String getShortenRawResponse(String originalLink) {
    return """
    {
     ok: true,
     result: {
         code: "fnSy",
         short_link: "shrtco.de/fnSy",
         full_short_link: "https://shrtco.de/fnSy",
         short_link2: "9qr.de/fnSy",
         full_short_link2: "https://9qr.de/fnSy",
         short_link3: "shiny.link/fnSy",
         full_short_link3: "https://shiny.link/fnSy",
         share_link: "shrtco.de/share/fnSy",
         full_share_link: "https://shrtco.de/share/fnSy",
         original_link: "$originalLink"
    }
}
    """;
  }

  static String getShortenRawErrorResponse(String originalLink) {
    return """
    {
     ok: false,
     error_code: 2,
     error: "This is not a valid URL, for more infos see shrtco.de/docs"
}
    """;
  }
}
