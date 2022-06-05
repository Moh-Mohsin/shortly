// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shrtcode_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ShrtcodeApiService implements ShrtcodeApiService {
  _ShrtcodeApiService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.shrtco.de/v2/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<ShortenResponse>> shorten({required url}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'url': url};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<ShortenResponse>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/shorten',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ShortenResponse.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
