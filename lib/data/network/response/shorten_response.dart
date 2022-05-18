import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shorten_response.g.dart';

@JsonSerializable()
class ShortenResponse extends Equatable {
  @JsonKey(name: 'ok')
  final bool/*!*/ ok;

  @JsonKey(name: 'result')
  final ShortenDto/*!*/ result;

  ShortenResponse({@required this.ok, @required this.result});

  factory ShortenResponse.fromJson(Map<String, dynamic> json) =>
      _$ShortenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShortenResponseToJson(this);

  @override
  List<Object> get props => [ok, result];
}

@JsonSerializable()
class ShortenDto extends Equatable {
  @JsonKey(name: 'code')
  final String/*!*/ code;
  @JsonKey(name: 'short_link')
  final String/*!*/ shortLink;
  @JsonKey(name: 'full_short_link')
  final String/*!*/ fullShortLink;
  @JsonKey(name: 'short_link2')
  final String/*!*/ shortLink2;
  @JsonKey(name: 'full_short_link2')
  final String/*!*/ fullShortLink2;
  @JsonKey(name: 'share_link')
  final String/*!*/ shareLink;
  @JsonKey(name: 'full_share_link')
  final String/*!*/ fullShareLink;
  @JsonKey(name: 'original_link')
  final String/*!*/ originalLink;

  ShortenDto(
      {@required this.code,
      @required this.shortLink,
      @required this.fullShortLink,
      @required this.shortLink2,
      @required this.fullShortLink2,
      @required this.shareLink,
      @required this.fullShareLink,
      @required this.originalLink});

  factory ShortenDto.fromJson(Map<String, dynamic> json) =>
      _$ShortenDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ShortenDtoToJson(this);

  @override
  List<Object> get props => [
        code,
        shortLink,
        fullShortLink,
        shortLink2,
        fullShortLink2,
        shareLink,
        fullShareLink,
        originalLink
      ];
}
