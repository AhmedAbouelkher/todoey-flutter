import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
}

@UseMoor(tables: [Tasks], daos: [TaskDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          // Good for debugging - prints SQL in the console
          logStatements: true,
        )));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  final AppDatabase db;
  TaskDao(this.db) : super(db);
  Future<List<Task>> getAllTask() => select(tasks).get();
  Stream<List<Task>> watchAllTasks() {
    return (select(tasks)..orderBy(([(t) => OrderingTerm(expression: t.name)])))
        .watch();
  }

  Stream<List<Task>> watchCompletedTasks() {
    return (select(tasks)..where((t) => t.completed.equals(true))).watch();
  }

  Future insertTask(Insertable<Task> task) => into(tasks).insert(task);
  Future updateTask(Insertable<Task> task) => update(tasks).replace(task);
  Future deleteTask(Insertable<Task> task) => delete(tasks).delete(task);
}
