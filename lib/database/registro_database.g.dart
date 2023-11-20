// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registro_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorRegistroDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$RegistroDatabaseBuilder databaseBuilder(String name) =>
      _$RegistroDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$RegistroDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$RegistroDatabaseBuilder(null);
}

class _$RegistroDatabaseBuilder {
  _$RegistroDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$RegistroDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$RegistroDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<RegistroDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$RegistroDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$RegistroDatabase extends RegistroDatabase {
  _$RegistroDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  RegistroDao? _registroDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Registro` (`id` INTEGER, `condominio` TEXT NOT NULL, `latitude` TEXT NOT NULL, `longitude` TEXT NOT NULL, `status` TEXT NOT NULL, `date` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  RegistroDao get registroDao {
    return _registroDaoInstance ??= _$RegistroDao(database, changeListener);
  }
}

class _$RegistroDao extends RegistroDao {
  _$RegistroDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _registroInsertionAdapter = InsertionAdapter(
            database,
            'Registro',
            (Registro item) => <String, Object?>{
                  'id': item.id,
                  'condominio': item.condominio,
                  'latitude': item.latitude,
                  'longitude': item.longitude,
                  'status': item.status,
                  'date': item.date
                }),
        _registroDeletionAdapter = DeletionAdapter(
            database,
            'Registro',
            ['id'],
            (Registro item) => <String, Object?>{
                  'id': item.id,
                  'condominio': item.condominio,
                  'latitude': item.latitude,
                  'longitude': item.longitude,
                  'status': item.status,
                  'date': item.date
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Registro> _registroInsertionAdapter;

  final DeletionAdapter<Registro> _registroDeletionAdapter;

  @override
  Future<List<Registro>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Registro;',
        mapper: (Map<String, Object?> row) => Registro(
            row['condominio'] as String,
            row['latitude'] as String,
            row['longitude'] as String,
            row['status'] as String,
            row['date'] as String,
            row['id'] as int?));
  }

  @override
  Future<List<Registro>> findLastEntrace() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Registro ORDER BY datetime(date) DESC LIMIT 1;',
        mapper: (Map<String, Object?> row) => Registro(
            row['condominio'] as String,
            row['latitude'] as String,
            row['longitude'] as String,
            row['status'] as String,
            row['date'] as String,
            row['id'] as int?));
  }

  @override
  Future<void> insertRegistro(Registro registro) async {
    await _registroInsertionAdapter.insert(registro, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBook(Registro registro) async {
    await _registroDeletionAdapter.delete(registro);
  }
}
