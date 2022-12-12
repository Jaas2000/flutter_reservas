import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_flutter/data/database/booking_entity.dart';
import 'package:prueba_flutter/data/database/court_entity.dart';
import 'package:prueba_flutter/data/database/dao/booking_dao.dart';
import 'package:prueba_flutter/data/database/dao/court_dao.dart';
import 'package:prueba_flutter/data/database/database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase database;
  late CourtDao courtDao;
  late BookingDao bookingDao;

  setUp(() async {
    database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();

    courtDao = database.courtDao;
    bookingDao = database.bookingDao;
  });

  test('database court initially is empty', () async {
    final actual = await courtDao.listCourts();
    expect(actual, isEmpty);
  });
  test('insert court', () async {
    final court = Court(id: 1, name: 'Campo Test');
    await courtDao.insertCourt(court);

    final actual = await courtDao.listCourts();

    expect(actual, hasLength(1));
  });

  test('database booking initially is empty', () async {
    final actual = await bookingDao.listBookings();
    expect(actual, isEmpty);
  });

  test('insert booking', () async {
    final booking = Booking(name: 'Campo Test', date: '01/01/2022', weather: 'Clouds', courtId: "1");
    await bookingDao.insertBooking(booking);

    final actual = await bookingDao.listBookings();

    expect(actual, hasLength(1));
  });
  test('delete booking', () async {
    final booking = Booking(name: 'Campo Test', date: '01/01/2022', weather: 'Clouds', courtId: "1");
    await bookingDao.insertBooking(booking);

    await bookingDao.deleteBooking(1);

    final actual = await bookingDao.findBooking('1');
    expect(actual, null);
  });
}
