import 'package:floor/floor.dart';

@Entity(
  tableName: 'Court',
)

@entity
class Court {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  String name;

  Court({this.id, required this.name});
}