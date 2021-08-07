// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'api_module.dart';
import '../data/db/database.dart';
import 'db_module.dart';
import '../feature/history/domain/usecase/delete_short_url_use_case.dart';
import '../feature/history/domain/usecase/get_short_url_history_use_case.dart';
import '../feature/history/presentation/bloc/short_url_history_bloc.dart';
import '../feature/history/data/repository/short_url_history_repository.dart';
import '../feature/shorten/presentation/bloc/shorten_bloc.dart';
import '../feature/shorten/data/source/shorten_remote_data_source.dart';
import '../feature/shorten/data/repository/shorten_repository.dart';
import '../feature/shorten/domain/usecase/shorten_url_use_case.dart';
import '../data/network/api/shrtcode_api_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  final dbModule = _$DbModule();
  final apiModule = _$ApiModule();
  final resolvedAppDatabase = await dbModule.appDatabase;
  gh.factory<AppDatabase>(() => resolvedAppDatabase);
  gh.factory<Dio>(() => apiModule.getDio());
  gh.factory<ShrtcodeApiService>(
      () => apiModule.getShrtcodeApiService(get<Dio>()));
  gh.factory<DeleteShortUrlUseCase>(
      () => DeleteShortUrlUseCase(get<ShortUrlHistoryRepository>()));
  gh.factory<GetShortUrlHistoryUseCase>(
      () => GetShortUrlHistoryUseCase(get<ShortUrlHistoryRepository>()));
  gh.factory<ShortUrlHistoryBloc>(() => ShortUrlHistoryBloc(
      get<GetShortUrlHistoryUseCase>(), get<DeleteShortUrlUseCase>()));
  gh.factory<ShortenUrlUseCase>(
      () => ShortenUrlUseCase(get<ShortenRepository>()));
  gh.factory<ShortenBloc>(() => ShortenBloc(get<ShortenUrlUseCase>()));

  // Eager singletons must be registered in the right order
  gh.singleton<ShortUrlHistoryRepository>(
      ShortUrlHistoryRepositoryImpl(get<AppDatabase>()));
  gh.singleton<ShortenRemoteDataSource>(
      ShortenRemoteDataSourceImpl(get<ShrtcodeApiService>()));
  gh.singleton<ShortenRepository>(ShortenRepositoryImpl(
      get<ShortenRemoteDataSource>(), get<AppDatabase>()));
  return get;
}

class _$DbModule extends DbModule {}

class _$ApiModule extends ApiModule {}
