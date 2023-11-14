import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistroPontoWidget extends StatefulWidget {
  const RegistroPontoWidget({super.key});

  @override
  DropDownCondominioState createState() => DropDownCondominioState();

}

class DropDownCondominioState extends State<RegistroPontoWidget> {

  String selectedValue = 'Viva Mais';
  List<String> options = ['Viva Mais', 'Inspire', 'Nações Clube'];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(700, 1400));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                // const SizedBox(height: 2),
                const Text(
                  'Registro Ponto',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50), // Espaçamento entre as colunas
              // Segunda Coluna
            Column(
              children: [
                const Text(
                  'Condomínio',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: 'Viva Mais',
                  onChanged: (String? newValue) {
                      // Handle dropdown value change
                },
                items: ['Viva Mais', 'Inspire', 'Nações Clube']
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ), 
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){

                  }, 
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Entrada')
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
