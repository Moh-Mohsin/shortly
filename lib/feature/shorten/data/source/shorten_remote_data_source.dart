import 'package:injectable/injectable.dart';
import 'package:shortly/data/exceptions/exceptions.dart';
import 'package:shortly/data/network/api/shrtcode_api_service.dart';
import 'package:shortly/data/network/response/shorten_response.dart';

abstract class ShortenRemoteDataSource {
  Future<ShortenResponse> shortenUrl(String url);
}

@Singleton(as:ShortenRemoteDataSource)
class ShortenRemoteDataSourceImpl extends ShortenRemoteDataSource {
  final ShrtcodeApiService shrtcodeApiService;

  ShortenRemoteDataSourceImpl(this.shrtcodeApiService);

  @override
  Future<ShortenResponse> shortenUrl(String url) async {
    var response = await shrtcodeApiService.shorten(url: url);
    if (response.response.statusCode >= 200 && response.response.statusCode <= 300)
      return response.data;
    else {
      throw ServerException();
    }
  }
}
