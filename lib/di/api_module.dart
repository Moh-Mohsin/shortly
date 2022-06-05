import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shortly/data/network/api/shrtcode_api_service.dart';

@module
abstract class ApiModule {
  Dio getDio() {
    var dio = Dio();
     
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90));
    return dio;
  }

  ShrtcodeApiService getShrtcodeApiService(Dio dio) {
    return ShrtcodeApiService(dio);
  }
}
