import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shortly/data/exceptions/exceptions.dart';
import 'package:shortly/data/result.dart';
import 'package:shortly/feature/shorten/domain/usecase/shorten_url_use_case.dart';
import 'package:shortly/feature/shorten/presentation/bloc/shorten_bloc.dart';

import '../../../../dummy.dart';

class MockShortenUrlUseCase extends Mock implements ShortenUrlUseCase {}

void main() {
  ShortenBloc shortenBloc;
  MockShortenUrlUseCase mockShortenUrlUseCase;

  setUp(() {
    mockShortenUrlUseCase = MockShortenUrlUseCase();
    shortenBloc = ShortenBloc(mockShortenUrlUseCase);
  });

  tearDown(() {
    shortenBloc.close();
  });

  group(
    'shorten url',
    () {
      test('should emit loading and then error', () async {
        //arrange
        final appException = ServerException();
        when(mockShortenUrlUseCase(any))
            .thenAnswer((_) async => Error(appException));

        //act
        final link = "http://youtube.com";
        shortenBloc.shortenUrl(link);

        //assert
        expectLater(
          shortenBloc.stream,
          emitsInOrder(
            [ShortenLoading(), ShortenFailure(appException.msg, appException)],
          ),
        );
      });

      test(
        'should emit loading and then success',
        () async {
          //arrange
          final link = "http://youtube.com";
          final shortUrl = Dummy.getShortUrl(link);
          when(mockShortenUrlUseCase(any))
              .thenAnswer((_) async => Success(shortUrl));

          //act
          shortenBloc.shortenUrl(link);

          //assert
          expectLater(
            shortenBloc.stream,
            emitsInOrder(
              [ShortenLoading(), ShortenSuccess(shortUrl)],
            ),
          );
        },
      );
    },
  );
}
