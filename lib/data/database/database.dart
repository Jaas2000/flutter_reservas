// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:prueba_flutter/data/database/booking_entity.dart';
import 'package:prueba_flutter/data/database/dao/booking_dao.dart';
import 'package:prueba_flutter/data/database/dao/court_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'court_entity.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Court, Booking], views: [BookingCourt])
abstract class AppDatabase extends FloorDatabase {
  CourtDao get courtDao;
  BookingDao get bookingDao;
}