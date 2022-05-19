// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../data/db/database.dart' as _i3;
import '../data/network/api/shrtcode_api_service.dart' as _i7;
import '../feature/history/data/repository/short_url_history_repository.dart'
    as _i6;
import '../feature/history/domain/usecase/delete_short_url_use_case.dart'
    as _i10;
import '../feature/history/domain/usecase/get_short_url_history_use_case.dart'
    as _i11;
import '../feature/history/presentation/bloc/short_url_history_bloc.dart'
    as _i13;
import '../feature/onboard/domian/data/repository/benefits_repository.dart'
    as _i9;
import '../feature/onboard/domian/data/source/benefits_local_data_source.dart'
    as _i8;
import '../feature/onboard/domian/usecase/is_benefits_skipped_use_case.dart'
    as _i12;
import '../feature/onboard/domian/usecase/skip_benefits_use_case.dart' as _i17;
import '../feature/onboard/presentation/bloc/benefits_bloc.dart' as _i18;
import '../feature/shorten/data/repository/shorten_repository.dart' as _i15;
import '../feature/shorten/data/source/shorten_remote_data_source.dart' as _i14;
import '../feature/shorten/domain/usecase/shorten_url_use_case.dart' as _i16;
import '../feature/shorten/presentation/bloc/shorten_bloc.dart' as _i19;
import 'api_module.dart' as _i21;
import 'db_module.dart' as _i20;
import 'shared_pref_module.dart'
    as _i22; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final dbModule = _$DbModule();
  final apiModule = _$ApiModule();
  final sharedPrefModule = _$SharedPrefModule();
  await gh.factoryAsync<_i3.AppDatabase>(() => dbModule.appDatabase,
      preResolve: true);
  gh.factory<_i4.Dio>(() => apiModule.getDio());
  await gh.factoryAsync<_i5.SharedPreferences>(
      () => sharedPrefModule.sharedPreferences,
      preResolve: true);
  gh.singleton<_i6.ShortUrlHistoryRepository>(
      _i6.ShortUrlHistoryRepositoryImpl(get<_i3.AppDatabase>()));
  gh.factory<_i7.ShrtcodeApiService>(
      () => apiModule.getShrtcodeApiService(get<_i4.Dio>()));
  gh.singleton<_i8.BenefitsLocalDataSource>(
      _i8.BenefitsLocalDataSourceImpl(get<_i5.SharedPreferences>()));
  gh.singleton<_i9.BenefitsRepository>(
      _i9.BenefitsRepositoryImpl(get<_i8.BenefitsLocalDataSource>()));
  gh.factory<_i10.DeleteShortUrlUseCase>(
      () => _i10.DeleteShortUrlUseCase(get<_i6.ShortUrlHistoryRepository>()));
  gh.factory<_i11.GetShortUrlHistoryUseCase>(() =>
      _i11.GetShortUrlHistoryUseCase(get<_i6.ShortUrlHistoryRepository>()));
  gh.factory<_i12.IsBenefitsSkippedUseCase>(
      () => _i12.IsBenefitsSkippedUseCase(get<_i9.BenefitsRepository>()));
  gh.factory<_i13.ShortUrlHistoryBloc>(() => _i13.ShortUrlHistoryBloc(
      get<_i11.GetShortUrlHistoryUseCase>(),
      get<_i10.DeleteShortUrlUseCase>()));
  gh.singleton<_i14.ShortenRemoteDataSource>(
      _i14.ShortenRemoteDataSourceImpl(get<_i7.ShrtcodeApiService>()));
  gh.singleton<_i15.ShortenRepository>(_i15.ShortenRepositoryImpl(
      get<_i14.ShortenRemoteDataSource>(), get<_i3.AppDatabase>()));
  gh.factory<_i16.ShortenUrlUseCase>(
      () => _i16.ShortenUrlUseCase(get<_i15.ShortenRepository>()));
  gh.factory<_i17.SkipBenefitsUseCase>(
      () => _i17.SkipBenefitsUseCase(get<_i9.BenefitsRepository>()));
  gh.factory<_i18.BenefitsBloc>(
      () => _i18.BenefitsBloc(get<_i17.SkipBenefitsUseCase>()));
  gh.factory<_i19.ShortenBloc>(
      () => _i19.ShortenBloc(get<_i16.ShortenUrlUseCase>()));
  return get;
}

class _$DbModule extends _i20.DbModule {}

class _$ApiModule extends _i21.ApiModule {}

class _$SharedPrefModule extends _i22.SharedPrefModule {}
