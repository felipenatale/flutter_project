import 'package:flutter/material.dart';
import 'package:flutter_final_project/dao/condominio_dao.dart';
import 'package:flutter_final_project/dao/registro_dao.dart';
import 'package:flutter_final_project/database/registro_database.dart';
import 'package:flutter_final_project/database/app_database.dart';
import 'package:flutter_final_project/models/condominio.dart';
import 'package:flutter_final_project/models/registro.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_final_project/screens/confirm_entrada.dart';
import 'package:flutter_final_project/utils/constants.dart';
import 'package:geolocator/geolocator.dart';

class RegistroPontoWidget extends StatefulWidget {
  const RegistroPontoWidget({Key? key}) : super(key: key);

  @override
  State<RegistroPontoWidget> createState() => _RegistroPontoWidgetState();
}

class _RegistroPontoWidgetState extends State<RegistroPontoWidget> {
  CondominioDao? condominioDao;
  RegistroDao? registroDao;
  List<Condominio> condominios = [];
  List<Registro> registros = [];
  String _latitude = '';
  String _longitude = '';
  String selectedCondominio = '';
  String condomioName = '';
  String status = '';

  @override
  void initState() {
    _determinePosition().then((Position position) {
      setState(() {
        _latitude = position.latitude.toString();
        _longitude = position.longitude.toString();
      });
    });
    super.initState();
    _initializDatabase();
  }

  _initializDatabase() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    condominioDao = database.condominioDao;

    final databaseRegistry = await $FloorRegistroDatabase
        .databaseBuilder('registro_database.db')
        .build();
    registroDao = databaseRegistry.registroDao;

    await _addCondominios();
    await _getAllCondominios();
    await _getRegistro();
  }

  _addCondominios() async {
    if (condominioDao != null) {
      final existeCondominios = await condominioDao!.findAll();
      if (existeCondominios.isEmpty) {
        await condominioDao!.insertCondominio(Condominio("Viva Mais", null));
        await condominioDao!.insertCondominio(Condominio("Inspire", null));
        await condominioDao!.insertCondominio(Condominio("Nações Clube", null));
      }
    }
  }

  _getAllCondominios() async {
    if (condominioDao != null) {
      final result = await condominioDao!.findAll();
      setState(() {
        condominios = result;
      });
    }
  }

  _getRegistro() async {
    if (registroDao != null) {
      final result = await registroDao!.findLastEntrace();
      setState(() {
        registros = result;
      });
    }
  }

  _addRegistro() async {
    String currentStatus = 'Saida';

    print(registros);
    print(condominios);
    if (registros.isEmpty) {
      currentStatus = 'Entrada';
      setState(() {
        status = 'Entrada';
      });
    } else {
      print('_addRegistro else');
      if (registros[0].status == 'Saida') {
        currentStatus = 'Entrada';
        setState(() {
          status = 'Entrada';
        });
      } else {
        setState(() {
          status = 'Saida';
        });
      }
    }
    print(selectedCondominio);
    print(_latitude);
    print(_longitude);
    print(currentStatus);
    print(DateTime.now().toString());

    final registro = Registro(selectedCondominio, _latitude, _longitude,
        currentStatus, DateTime.now().toString(), null);
    await registroDao!.insertRegistro(registro);
  }

  checkCondomioToRegistry() {
    print('entrou checkCondomioToRegistry');
    if (registros.isNotEmpty) {
      // || registros[0].status == 'Saida'
      setState(() {
        print(registros);
        condomioName = registros[0].condominio;
        status = registros[0].status;
      });
      condominios.map((condominio) {
        print(condomioName);
        if (condominio.nome == condomioName && status == 'Entrada') {
          return DropdownMenuItem<String>(
            value: condomioName,
            child: Text(condomioName),
          );
        }
      }).toList();
    } else {
      print('entrou checkCondomioToRegistry else');
      condominios.map((condominio) {
        return DropdownMenuItem<String>(
          value: condominio.nome,
          child: Text(condominio.nome),
        );
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(700, 1400));
    return Scaffold(
      body: Padding(
        padding: paddingRegistroPonto,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Primeira Coluna
            Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 300,
                  height: 200,
                ),
                const Text(
                  titleScreanResgister,
                  style: textStyletitleScreanResgister,
                ),
              ],
            ),
            const SizedBox(height: 50),
            // Segunda Coluna
            Column(
              children: [
                const Text(
                  subtitleCondominium,
                  style: textStyleSubtitleCondominium,
                  textAlign: textAlingSubtitleCondominium,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  onChanged: (value) {
                    // Handle dropdown value change
                    setState(() {
                      selectedCondominio = value.toString();
                    });
                  },
                  // items: checkCondomioToRegistry(),
                  items: condominios.map((condominio) {
                    return DropdownMenuItem<String>(
                      value: condominio.nome,
                      child: Text(condominio.nome),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    contentPadding: paddingInputDecorationDropDown,
                    border:
                        OutlineInputBorder(borderRadius: borderRadiusAllScreen),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => {
                    _addRegistro(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistroEntradaWidget(
                              latitude: _latitude,
                              longitude: _longitude,
                              condominio: selectedCondominio,
                              status: status)),
                    )
                  },
                  style: ElevatedButton.styleFrom(
                    padding: paddingElevatedButtonRegister,
                    backgroundColor: colorElevatedButtonRegister,
                    shape: RoundedRectangleBorder(
                        borderRadius: borderRadiusAllScreen),
                  ),
                  child: const Text(titleButtonRegister),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.

  return await Geolocator.getCurrentPosition();
}
