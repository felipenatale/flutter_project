import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistroPontoWidget extends StatefulWidget {
  const RegistroPontoWidget({Key? key}) : super(key: key);

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
                const Text(
                  'Registro Ponto',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
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
                  items: options.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistroPontoEntrada()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    backgroundColor: const Color(0xFFFB7833),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Entrada'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


class RegistroPontoEntrada extends StatelessWidget {
  const RegistroPontoEntrada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDateTime =
        "2023-11-18 12:34";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Ponto'),
        backgroundColor: const Color(0xFFFB7833),
      ),
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
              ],
            ),
            // Segunda coluna
            const SizedBox(height: 45),
            Column(
              children: [
                const Text(
                  'Entrada processada com sucesso',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 35),
                Text(
                  formattedDateTime,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            // Terceira coluna
            const SizedBox(height: 45),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ExitApp()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    backgroundColor: const Color(0xFFFB7833),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Sair'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


class ExitApp extends StatelessWidget {
  const ExitApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Ponto'),
        backgroundColor: const Color(0xFFFB7833),
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Você realmente deseja sair do SindHub?',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Perform any necessary actions before exiting the app
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    backgroundColor: const Color(0xFFFB7833),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Exit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
