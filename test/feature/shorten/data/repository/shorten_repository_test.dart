import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shortly/data/db/dao/short_url_dao.dart';
import 'package:shortly/data/db/database.dart';
import 'package:shortly/data/exceptions/exceptions.dart';
import 'package:shortly/data/model/short_url.dart';
import 'package:shortly/data/result.dart';
import 'package:shortly/feature/shorten/data/repository/shorten_repository.dart';
import 'package:shortly/feature/shorten/data/source/shorten_remote_data_source.dart';

import '../../../../dummy.dart';
import 'shorten_repository_test.mocks.dart';

class MockShortenRemoteDataSource extends Mock
    implements ShortenRemoteDataSource {}

class MockAppDatabase extends Mock implements AppDatabase {}

@GenerateMocks([ShortUrlDao])
void main() {
  late MockShortenRemoteDataSource mockShortenRemoteDataSource;
  late MockAppDatabase mockAppDatabase;
  MockShortUrlDao? mockShortUrlDao;
  late ShortenRepositoryImpl shortenRepositoryImpl;
  setUp(() {
    mockShortenRemoteDataSource = MockShortenRemoteDataSource();
    mockAppDatabase = MockAppDatabase();
    mockShortUrlDao = MockShortUrlDao();
    shortenRepositoryImpl =
        ShortenRepositoryImpl(mockShortenRemoteDataSource, mockAppDatabase);
  });

  group('ShortenRepositoryImpl', () {
    final link = "http://youtube.com";
    final shortenResponse = Dummy.getShortenResponse(link);
    final int timestamp = 165413216;
    final shortUrl = shortenResponse.result.mapToShortUrl(timestamp);

    test('should return a ShortUrl when given a valid link', () async {
      //given
      when(mockShortenRemoteDataSource.shortenUrl(link))
          .thenAnswer((_) async => shortenResponse);
      when(mockAppDatabase.shortUrlDao).thenAnswer(((_) => mockShortUrlDao!));
      when(mockShortUrlDao!.insertShortUrl(shortUrl)).thenAnswer((_) async {
        return;
      });

      //when
      final Result<ShortUrl> result =
          await shortenRepositoryImpl.shortenUrl(link);

      //then
      verify(mockShortenRemoteDataSource.shortenUrl(link));
      verify(mockShortUrlDao!.insertShortUrl(argThat(isNotNull)));
      expect(result, isA<Success>());
      expect((result as Success<ShortUrl>).data.originalLink,
          equals(shortUrl.originalLink));
      expect(result.data.fullShortLink,
          equals(shortUrl.fullShortLink));
    });

    test('should return an error with appropriate exception', () async {
      //given
      var serverException = ServerException();
      when(mockShortenRemoteDataSource.shortenUrl(link)).thenAnswer((_) {
        return throw serverException;
      });

      //when
      final Result<ShortUrl> result =
          await shortenRepositoryImpl.shortenUrl(link);

      //then
      verify(mockShortenRemoteDataSource.shortenUrl(link));
      verifyNever(mockShortUrlDao!.insertShortUrl(any));
      expect(result, isA<Error>());
      expect((result as Error<ShortUrl>).appException, serverException);
    });
  });
}
