import 'package:floor/floor.dart';

@entity
class Condominio {
  
  @primaryKey
  final int? id;
  final String nome;
  
  Condominio(this.nome, this.id);
}
