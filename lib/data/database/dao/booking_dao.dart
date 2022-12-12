import 'package:floor/floor.dart';

import '../booking_entity.dart';

@dao
abstract class BookingDao {
  @Query(
      'SELECT Booking.id, Booking.name, Booking.date, Booking.weather, Court.name as courtName FROM Booking INNER JOIN Court ON Court.id = Booking.courtId ORDER BY Booking.date ASC')
  Future<List<BookingCourt>> listBookings();

  @Query('SELECT * FROM Booking WHERE courtId = :id AND date = :date')
  Future<List<Booking>> findCountBookings(String id, String date);

  @Query('SELECT * FROM Booking WHERE id = :id')
  Future<Booking?> findBooking(String id);

  @insert
  Future<void> insertBooking(Booking booking);

  @Query('DELETE FROM Booking WHERE id = :id')
  Future<Booking?> deleteBooking(int id);
}

@DatabaseView(
    'SELECT Booking.id, Booking.name, Booking.date, Booking.weather, Court.name as courtName FROM Booking INNER JOIN Court ON Court.id = Booking.courtId ORDER BY Booking.date ASC')
class BookingCourt {
  final int id;
  final String name;
  final String date;
  final String weather;
  final String courtName;

  BookingCourt(this.id, this.name, this.date, this.weather, this.courtName);
}
