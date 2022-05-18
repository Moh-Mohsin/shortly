// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shrtcode_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ShrtcodeApiService implements ShrtcodeApiService {
  _ShrtcodeApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.shrtco.de/v2/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<HttpResponse<ShortenResponse>> shorten({url}) async {
    ArgumentError.checkNotNull(url, 'url');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'url': url};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/shorten',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,),
        data: _data);
    final value = ShortenResponse.fromJson(_result.data);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }
}
