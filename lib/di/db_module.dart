import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shortly/data/db/database.dart';
import 'package:shortly/data/network/api/shrtcode_api_service.dart';

@module
abstract class DbModule {
  @preResolve
  Future<AppDatabase> get appDatabase =>
      $FloorAppDatabase.databaseBuilder('app_database.db').build();
}
