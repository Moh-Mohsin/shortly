import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shortly/data/exceptions/exceptions.dart';
import 'package:shortly/data/network/response/shorten_response.dart';
import 'package:shortly/data/result.dart';
import 'package:shortly/feature/shorten/data/model/short_url.dart';
import 'package:shortly/feature/shorten/data/source/shorten_remote_data_source.dart';

abstract class ShortenRepository {
  Future<Result<ShortUrl>> shortenUrl(String url);
}

@Singleton(as: ShortenRepository)
class ShortenRepositoryImpl extends ShortenRepository {
  final ShortenRemoteDataSource shortenRemoteDataSource;

  ShortenRepositoryImpl(this.shortenRemoteDataSource);

  @override
  Future<Result<ShortUrl>> shortenUrl(String url) async {
    try {
      final response = await shortenRemoteDataSource.shortenUrl(url);
      return Success(response.result.mapToShortUrl());
    } catch (e){
      return Error<ShortUrl>(ServerException());
    }
  }

}