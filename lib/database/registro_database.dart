import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:flutter_final_project/dao/registro_dao.dart';
import 'package:flutter_final_project/models/registro.dart';

part 'registro_database.g.dart';

@Database(version: 1, entities: [Registro])
abstract class RegistroDatabase extends FloorDatabase {
  RegistroDao get registroDao;
}
