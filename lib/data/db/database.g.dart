// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ShortUrlDao _shortUrlDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ShortUrl` (`code` TEXT, `fullShortLink` TEXT, `originalLink` TEXT, `timestamp` INTEGER, PRIMARY KEY (`code`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ShortUrlDao get shortUrlDao {
    return _shortUrlDaoInstance ??= _$ShortUrlDao(database, changeListener);
  }
}

class _$ShortUrlDao extends ShortUrlDao {
  _$ShortUrlDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _shortUrlInsertionAdapter = InsertionAdapter(
            database,
            'ShortUrl',
            (ShortUrl item) => <String, dynamic>{
                  'code': item.code,
                  'fullShortLink': item.fullShortLink,
                  'originalLink': item.originalLink,
                  'timestamp': item.timestamp
                },
            changeListener),
        _shortUrlDeletionAdapter = DeletionAdapter(
            database,
            'ShortUrl',
            ['code'],
            (ShortUrl item) => <String, dynamic>{
                  'code': item.code,
                  'fullShortLink': item.fullShortLink,
                  'originalLink': item.originalLink,
                  'timestamp': item.timestamp
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ShortUrl> _shortUrlInsertionAdapter;

  final DeletionAdapter<ShortUrl> _shortUrlDeletionAdapter;

  @override
  Stream<List<ShortUrl>> findAllShortUrls() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM ShortUrl ORDER BY timestamp DESC',
        queryableName: 'ShortUrl',
        isView: false,
        mapper: (Map<String, dynamic> row) => ShortUrl(
            row['code'] as String,
            row['fullShortLink'] as String,
            row['originalLink'] as String,
            row['timestamp'] as int));
  }

  @override
  Future<void> insertShortUrl(ShortUrl shortUrl) async {
    await _shortUrlInsertionAdapter.insert(
        shortUrl, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteShortUrl(ShortUrl shortUrl) async {
    await _shortUrlDeletionAdapter.delete(shortUrl);
  }
}
