import 'package:flutter/material.dart';
import 'package:flutter_final_project/dao/condominio_dao.dart';
import 'package:flutter_final_project/database/app_database.dart';
import 'package:flutter_final_project/models/condominio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_final_project/screens/confirm_entrada.dart';
import 'package:flutter_final_project/utils/constants.dart';

class RegistroPontoWidget extends StatefulWidget {
  const RegistroPontoWidget({Key? key}) : super(key: key);

  @override
  State<RegistroPontoWidget> createState() => _RegistroPontoWidgetState();
}

class _RegistroPontoWidgetState extends State<RegistroPontoWidget> {

  CondominioDao? condominioDao;
  List<Condominio> condominios = [];

  @override
  void initState(){
    super.initState();
    _initializDatabase();
  }

  _initializDatabase() async{
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    condominioDao = database.condominioDao;

    await _addCondominios();
    await _getAllCondominios();
  }

  _addCondominios() async{
    if(condominioDao != null) {
      final existeCondominios = await condominioDao!.findAll();
      if (existeCondominios.isEmpty) {
        await condominioDao!.insertCondominio(Condominio("Viva Mais", null));
        await condominioDao!.insertCondominio(Condominio("Inspire", null));
        await condominioDao!.insertCondominio(Condominio("Nações Clube", null));
      }
    }
  }

  _getAllCondominios() async{
    if(condominioDao != null){
      final result = await condominioDao!.findAll();
      setState(() {
        condominios = result;
      });
    }
  }

  final widgetRegistroEntrada = const RegistroEntradaWidget();

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
                  onChanged: (String? newValue) {
                    // Handle dropdown value change
                  },
                  items: condominios.map((Condominio condominio){
                    return DropdownMenuItem<String>(
                      value: condominio.id.toString(),
                      child: Text(condominio.nome),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    contentPadding: paddingInputDecorationDropDown,
                    border: OutlineInputBorder(borderRadius: borderRadiusAllScreen),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => widgetRegistroEntrada),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: paddingElevatedButtonRegister,
                    backgroundColor: colorElevatedButtonRegister,
                    shape: RoundedRectangleBorder(borderRadius: borderRadiusAllScreen),
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
