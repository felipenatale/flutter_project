import 'package:floor/floor.dart';
import 'package:flutter_final_project/models/condominio.dart';

@dao
abstract class CondominioDao{

  @Query("SELECT  * FROM Condominio")
  Future<List<Condominio>> findAll();

  @insert
  Future<void> insertCondominio(Condominio condominios);
}