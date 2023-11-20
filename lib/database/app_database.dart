import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:flutter_final_project/dao/condominio_dao.dart';
import 'package:flutter_final_project/models/condominio.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [Condominio])
abstract class AppDatabase extends FloorDatabase {
  CondominioDao get condominioDao;
}
