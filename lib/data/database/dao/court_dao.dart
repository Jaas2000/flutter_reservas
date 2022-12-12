import 'package:floor/floor.dart';

import '../court_entity.dart';

@dao
abstract class CourtDao {
  @Query('SELECT * FROM Court')
  Future<List<Court>> listCourts();

  @Query('SELECT * FROM Court WHERE id = :id')
  Future<Court?> findBookingById(int id);

  @insert
  Future<void> insertCourt(Court court);

}