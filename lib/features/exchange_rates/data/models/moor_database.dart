import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class CVRates extends Table {
  TextColumn get currency => text().withLength(min: 1, max: 50)();
  RealColumn get value => real()();
}

@UseMoor(tables: [CVRates])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        )));

  @override
  int get schemaVersion => 1;

  Future<List<CVRate>> getAllTasks() => select(cVRates).get();

  Future insertTask(CVRate task) => into(cVRates).insert(task);
  Future resetDb() async {
    for (var table in allTables) {
      await delete(table).go();
    }
  }
}
