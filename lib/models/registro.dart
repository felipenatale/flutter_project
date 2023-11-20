import 'package:floor/floor.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';

@entity
class Registro {
  @primaryKey
  final int? id;
  final String condominio;
  final String latitude;
  final String longitude;
  final String status;
  final String date;

  Registro(this.condominio, this.latitude, this.longitude, this.status,
      this.date, this.id);
}
