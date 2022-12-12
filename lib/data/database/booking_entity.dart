import 'package:floor/floor.dart';
import 'package:prueba_flutter/data/database/court_entity.dart';

@Entity(
  tableName: 'Booking',
  foreignKeys: [
    ForeignKey(
      childColumns: ['courtId'],
      parentColumns: ['id'],
      entity: Court,
    )
  ],
)

@entity
class Booking {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  String name;
  String date;
  String weather;
  String courtId;

  Booking({this.id, required this.name, required this.date, required this.weather, required this.courtId});
}