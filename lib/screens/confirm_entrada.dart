import 'package:flutter/material.dart';
import 'package:flutter_final_project/screens/exit_app.dart';

class RegistroEntradaWidget extends StatelessWidget {
  const RegistroEntradaWidget({super.key});


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