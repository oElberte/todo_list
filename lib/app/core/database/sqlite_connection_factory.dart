//Singleton
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class SqliteConnectionFactory {
  static const _version = 1;
  static const _databaseName = 'TODO_LIST_PROVIDER';

  static SqliteConnectionFactory? _instance;

  Database? _db;
  final _lock = Lock();

  SqliteConnectionFactory._();

  factory SqliteConnectionFactory() {
    _instance ??= SqliteConnectionFactory._();

    return _instance!;
  }

  Future<Database> openConnection() async {
    var databasePath = await getDatabasesPath();
    var databasePathFinal = join(databasePath, _databaseName);

    /* Since this class is a singleton, we do this check everytime to ensure that
    db is not already initialized */
    if (_db == null) {
      /* Lock().synchronized make the next step in the event loop wait for this to
      complete to then, let another connection try to be established, and the 
      null-aware assignment doesn't let it, as he won't be null anymore */
      await _lock.synchronized(() async {
        _db ??= await openDatabase(
          databasePathFinal,
          version: _version,
          onConfigure: _onConfigure,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
          onDowngrade: _onDowngrade,
        );
      });
    }
    return _db!;
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {}

  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {}

  Future<void> _onDowngrade(Database db, int oldVersion, int version) async {}
}
