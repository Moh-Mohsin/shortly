import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:shortly/data/network/response/shorten_response.dart';
part 'shrtcode_api_service.g.dart';

@RestApi(baseUrl: "https://api.shrtco.de/v2/")
abstract class ShrtcodeApiService {
  factory ShrtcodeApiService(Dio dio) = _ShrtcodeApiService;
 
  @GET("/shorten")
  Future<HttpResponse<ShortenResponse>> shorten(
      {@Query("url") required String url, });
}
