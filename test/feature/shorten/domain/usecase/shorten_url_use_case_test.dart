import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shortly/data/model/short_url.dart';
import 'package:shortly/data/result.dart';
import 'package:shortly/feature/shorten/data/repository/shorten_repository.dart';
import 'package:shortly/feature/shorten/domain/usecase/shorten_url_use_case.dart';

import '../../../../dummy.dart';
import 'shorten_url_use_case_test.mocks.dart';

@GenerateMocks([ShortenRepository])
void main() {
  late ShortenUrlUseCase shortenUrlUseCase;
  late MockShortenRepository mockShortenRepository;
  setUp(() {
    mockShortenRepository = MockShortenRepository();
    shortenUrlUseCase = ShortenUrlUseCase(mockShortenRepository);
  });

  group('MockShortenRepository', () {
    final link = "http://youtube.com";
    final shortenResponse = Dummy.getShortenResponse(link);
    final int timestamp = 165413216;
    final shortUrl = shortenResponse.result.mapToShortUrl(timestamp);

    test('should return successfully', () async {
      //given
      when(mockShortenRepository.shortenUrl(link))
          .thenAnswer((_) async => Success(shortUrl));
      //when
      final result = await shortenUrlUseCase(link);

      //then
      verify(mockShortenRepository.shortenUrl(link));
      expect(result, isA<Success>());
      expect((result as Success<ShortUrl>).data, equals(shortUrl));
    });
  });
}
