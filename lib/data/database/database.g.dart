// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
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

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

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
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
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
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CourtDao? _courtDaoInstance;

  BookingDao? _bookingDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
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
            'CREATE TABLE IF NOT EXISTS `Court` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Booking` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `date` TEXT NOT NULL, `weather` TEXT NOT NULL, `courtId` TEXT NOT NULL, FOREIGN KEY (`courtId`) REFERENCES `Court` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await database.execute(
            'CREATE VIEW IF NOT EXISTS `BookingCourt` AS SELECT Booking.id, Booking.name, Booking.date, Booking.weather, Court.name as courtName FROM Booking INNER JOIN Court ON Court.id = Booking.courtId ORDER BY Booking.date ASC');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CourtDao get courtDao {
    return _courtDaoInstance ??= _$CourtDao(database, changeListener);
  }

  @override
  BookingDao get bookingDao {
    return _bookingDaoInstance ??= _$BookingDao(database, changeListener);
  }
}

class _$CourtDao extends CourtDao {
  _$CourtDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _courtInsertionAdapter = InsertionAdapter(
            database,
            'Court',
            (Court item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Court> _courtInsertionAdapter;

  @override
  Future<List<Court>> listCourts() async {
    return _queryAdapter.queryList('SELECT * FROM Court',
        mapper: (Map<String, Object?> row) =>
            Court(id: row['id'] as int?, name: row['name'] as String));
  }

  @override
  Future<Court?> findBookingById(int id) async {
    return _queryAdapter.query('SELECT * FROM Court WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Court(id: row['id'] as int?, name: row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertCourt(Court court) async {
    await _courtInsertionAdapter.insert(court, OnConflictStrategy.abort);
  }
}

class _$BookingDao extends BookingDao {
  _$BookingDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _bookingInsertionAdapter = InsertionAdapter(
            database,
            'Booking',
            (Booking item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'date': item.date,
                  'weather': item.weather,
                  'courtId': item.courtId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Booking> _bookingInsertionAdapter;

  @override
  Future<List<BookingCourt>> listBookings() async {
    return _queryAdapter.queryList(
        'SELECT Booking.id, Booking.name, Booking.date, Booking.weather, Court.name as courtName FROM Booking INNER JOIN Court ON Court.id = Booking.courtId ORDER BY Booking.date ASC',
        mapper: (Map<String, Object?> row) => BookingCourt(
            row['id'] as int,
            row['name'] as String,
            row['date'] as String,
            row['weather'] as String,
            row['courtName'] as String));
  }

  @override
  Future<List<Booking>> findCountBookings(
    String id,
    String date,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Booking WHERE courtId = ?1 AND date = ?2',
        mapper: (Map<String, Object?> row) => Booking(
            id: row['id'] as int?,
            name: row['name'] as String,
            date: row['date'] as String,
            weather: row['weather'] as String,
            courtId: row['courtId'] as String),
        arguments: [id, date]);
  }

  @override
  Future<Booking?> findBooking(String id) async {
    return _queryAdapter.query('SELECT * FROM Booking WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Booking(
            id: row['id'] as int?,
            name: row['name'] as String,
            date: row['date'] as String,
            weather: row['weather'] as String,
            courtId: row['courtId'] as String),
        arguments: [id]);
  }

  @override
  Future<Booking?> deleteBooking(int id) async {
    return _queryAdapter.query('DELETE FROM Booking WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Booking(
            id: row['id'] as int?,
            name: row['name'] as String,
            date: row['date'] as String,
            weather: row['weather'] as String,
            courtId: row['courtId'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertBooking(Booking booking) async {
    await _bookingInsertionAdapter.insert(booking, OnConflictStrategy.abort);
  }
}
