import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shortly/data/exceptions/exceptions.dart';
import 'package:shortly/data/network/api/shrtcode_api_service.dart';
import 'package:shortly/data/network/response/shorten_response.dart';

abstract class ShortenRemoteDataSource {
  Future<ShortenResponse> shortenUrl(String url);
}

@Singleton(as: ShortenRemoteDataSource)
class ShortenRemoteDataSourceImpl extends ShortenRemoteDataSource {
  final ShrtcodeApiService shrtcodeApiService;

  ShortenRemoteDataSourceImpl(this.shrtcodeApiService);

  @override
  Future<ShortenResponse> shortenUrl(String url) async {
    try {
      var response = await shrtcodeApiService.shorten(url: url);
      return response.data;
    } on DioError catch (dioError) {
      print("dioError");
      print(dioError);
      print(dioError.response);
      print(dioError.error);
      if (dioError.type == DioErrorType.response) {
        final errorCode = dioError.response.statusCode;
        final errorMessage = dioError.response.statusMessage;
        if (errorCode == 400) {
          throw BadRequestException();
        } else {
          throw GeneralException(errorMessage);
        }
      } else {
        if (dioError.error is SocketException) {
          throw NetworkException();
        } else {
          throw GeneralException(dioError.error.toString());
        }
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
