
import 'package:floor/floor.dart';
import 'package:shortly/data/model/short_url.dart';

@dao
abstract class ShortUrlDao {

  @Query('SELECT * FROM ShortUrl ORDER BY timestamp DESC')
  Stream<List<ShortUrl>> findAllShortUrls();


  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPerson(ShortUrl shortUrl);

  @delete
  Future<void> deleteShortUrl(ShortUrl shortUrl);

}