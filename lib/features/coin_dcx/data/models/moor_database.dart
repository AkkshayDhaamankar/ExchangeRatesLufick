import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

// Moor works by source gen. This file will all the generated code.
part 'moor_database.g.dart';

class CVRates extends Table {
  TextColumn get currency => text().withLength(min: 1, max: 50)();
  RealColumn get value => real()();
}

// This annotation tells the code generator which tables this DB works with
@UseMoor(tables: [CVRates])
// _$AppDatabase is the name of the generated class
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      // Specify the location of the database file
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          // Good for debugging - prints SQL in the console
          logStatements: true,
        )));

  // Bump this when changing tables and columns.
  // Migrations will be covered in the next part.
  @override
  int get schemaVersion => 1;

  // All tables have getters in the generated class - we can select the tasks table
  Future<List<CVRate>> getAllTasks() => select(cVRates).get();

  Future insertTask(CVRate task) => into(cVRates).insert(task);
  Future resetDb() async {
    for (var table in allTables) {
      await delete(table).go();
    }
  }
}
