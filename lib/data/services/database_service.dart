import 'package:prueba_flutter/data/database/booking_entity.dart';
import 'package:prueba_flutter/data/database/court_entity.dart';
import 'package:prueba_flutter/data/database/dao/booking_dao.dart';

import '../database/database.dart';

class DatabaseService {
  listCourts() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final courtDao = database.courtDao;
    List<Court> listCourt = await courtDao.listCourts();
    print(listCourt);
    return listCourt;
  }

  saveBooking(name, date, weather, courtId) async {
    try {
      final database =
          await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final bookingDao = database.bookingDao;

      final newBook = Booking(
          name: name,
          date: date,
          weather: weather,
          courtId: courtId.toString());

      await bookingDao.insertBooking(newBook);
      return true;
    } catch (e) {
      return false;
    }
  }

  booking(bookingId) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final bookingDao = database.bookingDao;
    Booking? booking = await bookingDao.findBooking(bookingId);

    return booking;
  }

  deleteBooking(String bookingId) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final bookingDao = database.bookingDao;

    await bookingDao.deleteBooking(int.parse(bookingId));
    return true;
  }

  listBookings() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final bookingDao = database.bookingDao;
    List<BookingCourt> listBooking = await bookingDao.listBookings();

    return listBooking;
  }

  countBookings(String courtId, String date) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final bookingDao = database.bookingDao;
    List<Booking> countBooking =
        await bookingDao.findCountBookings(courtId, date);
    return countBooking.length;
  }
}
