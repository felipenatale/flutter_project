import 'package:floor/floor.dart';
import 'package:flutter_final_project/models/registro.dart';

@dao
abstract class RegistroDao {
  @Query("SELECT * FROM Registro;")
  Future<List<Registro>> findAll();

  @Query("SELECT * FROM Registro ORDER BY datetime(date) DESC LIMIT 1;")
  Future<List<Registro>> findLastEntrace();

  @insert
  Future<void> insertRegistro(Registro registro);

  @delete
  Future<void> deleteBook(Registro registro);
}
