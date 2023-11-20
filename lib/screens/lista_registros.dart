import 'package:flutter/material.dart';
import 'package:flutter_final_project/dao/registro_dao.dart';
import 'package:flutter_final_project/database/registro_database.dart';
import 'package:flutter_final_project/models/registro.dart';
import 'package:flutter_final_project/utils/constants.dart';

class RegisterListWidget extends StatefulWidget {
  const RegisterListWidget({super.key});

  @override
  State<RegisterListWidget> createState() => _RegisterListWidgetState();
}

class _RegisterListWidgetState extends State<RegisterListWidget> {
  RegistroDao? dao;
  List<Registro> registros = [];
  final title = const Text("Registros");

  @override
  void initState() {
    super.initState();
    _initializDatabase();
  }

  _initializDatabase() async {
    final database = await $FloorRegistroDatabase
        .databaseBuilder('registro_database.db')
        .build();
    dao = database.registroDao;

    await _getAllRegistros();
  }

  _getAllRegistros() async {
    if (dao != null) {
      final result = await dao!.findAll();
      setState(() {
        registros = result;
      });
    }
  }

  _deleteRegistro(Registro book) async {
    if (dao != null) {
      await dao!.deleteRegistro(book);
      _getAllRegistros();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: title,
        backgroundColor: const Color(0xFFFB7833),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Função para voltar à tela anterior
          },
        ),
      ),
      body: ListView.builder(
          itemBuilder: (context, index) => _buildItem(index),
          itemCount: registros.length),
    );
  }

  Widget _buildItem(index) {
    Registro registro = registros[index];
    String registryDate = registro.date;
    return Padding(
      padding: listViewPadding,
      child: Card(
        child: ListTile(
          leading: Text(registro.id != null ? registro.id!.toString() : ""),
          title: Text(registro.condominio),
          subtitle: Text(
              "${registro.status} as: ${registryDate.substring(0, registro.date.indexOf('.'))}"),
          onLongPress: () {
            _deleteRegistro(registro);
          },
        ),
      ),
    );
  }
}
