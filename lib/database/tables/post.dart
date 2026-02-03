import 'package:drift/drift.dart';

// Define the table for posts
class Posts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(Constant(DateTime.now()))();
}
