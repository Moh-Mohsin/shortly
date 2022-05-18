import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shortly/data/exceptions/exceptions.dart';
import 'package:shortly/data/network/api/shrtcode_api_service.dart';
import 'package:shortly/data/network/response/shorten_response.dart';
import 'package:shortly/feature/shorten/data/source/shorten_remote_data_source.dart';

import '../../../../dummy.dart';

class MockShrtcodeApiService extends Mock implements ShrtcodeApiService {}

void main() {
  MockShrtcodeApiService mockShrtcodeApiService;
  ShortenRemoteDataSourceImpl shortenRemoteDataSourceImpl;

  setUp(() {
    mockShrtcodeApiService = MockShrtcodeApiService();
    shortenRemoteDataSourceImpl =
        ShortenRemoteDataSourceImpl(mockShrtcodeApiService);
  });

  group('ShortenRemoteDataSourceImpl', () {
    final link = "http://youtube.com";
    final ShortenResponse dummyShortenResponse = Dummy.getShortenResponse(link);

    test('should return successfully if the status code is 200', () async {
      //given
      when(mockShrtcodeApiService.shorten(url: link)).thenAnswer((_) async =>
          HttpResponse(
              dummyShortenResponse,
              Response(
                  data: Dummy.getShortenRawResponse(link), statusCode: 200)));
      //when
      final result = await shortenRemoteDataSourceImpl.shortenUrl(link);

      //then
      verify(mockShrtcodeApiService.shorten(url: link));
      expect(result, equals(dummyShortenResponse));
    });

    test('should throw a BadRequestException when the status code is 400',
        () async {
      //given
      when(mockShrtcodeApiService.shorten(url: link)).thenAnswer((_) async =>
          throw DioError(
              type: DioErrorType.response,
              response: Response(
                  data: Dummy.getShortenRawErrorResponse(link),
                  statusCode: 400)));

      //when
      final call = shortenRemoteDataSourceImpl.shortenUrl;

      expectLater(() => call(link), throwsA(isA<BadRequestException>()));
    });
  });
}
