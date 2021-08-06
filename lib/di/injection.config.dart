// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'api_module.dart';
import '../feature/shorten/presentation/bloc/shorten_bloc.dart';
import '../feature/shorten/data/source/shorten_remote_data_source.dart';
import '../feature/shorten/data/repository/shorten_repository.dart';
import '../feature/shorten/domain/usecase/shorten_url_use_case.dart';
import '../data/network/api/shrtcode_api_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final apiModule = _$ApiModule();
  gh.factory<Dio>(() => apiModule.getDio());
  gh.factory<ShrtcodeApiService>(
      () => apiModule.getShrtcodeApiService(get<Dio>()));
  gh.factory<ShortenUrlUseCase>(
      () => ShortenUrlUseCase(get<ShortenRepository>()));
  gh.factory<ShortenBloc>(() => ShortenBloc(get<ShortenUrlUseCase>()));

  // Eager singletons must be registered in the right order
  gh.singleton<ShortenRemoteDataSource>(
      ShortenRemoteDataSourceImpl(get<ShrtcodeApiService>()));
  gh.singleton<ShortenRepository>(
      ShortenRepositoryImpl(get<ShortenRemoteDataSource>()));
  return get;
}

class _$ApiModule extends ApiModule {}
