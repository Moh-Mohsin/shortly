
// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:floor/floor.dart';
import 'package:shortly/data/model/short_url.dart';

import 'dao/short_url_dao.dart';

part 'database.g.dart';

@Database(version: 1, entities: [ShortUrl])
abstract class AppDatabase extends FloorDatabase {
  ShortUrlDao get shortUrlDao;
}