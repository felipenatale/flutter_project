import 'package:flutter/material.dart';
import 'package:flutter_final_project/screens/exit_app.dart';
import 'package:geolocator/geolocator.dart';

class RegistroEntradaWidget extends StatefulWidget {
  final String latitude;
  final String longitude;
  final String condominio;
  final String status;
  const RegistroEntradaWidget(
      {super.key,
      required this.latitude,
      required this.longitude,
      required this.condominio,
      required this.status});
  //const RegistroEntradaWidget({super.key});

  @override
  State<RegistroEntradaWidget> createState() => _RegistroEntradaWidgetState();
}

class _RegistroEntradaWidgetState extends State<RegistroEntradaWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateTime.now().toString();
    String formattedDateTime =
        currentDate.substring(0, currentDate.indexOf('.'));

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
                Text(
                  '${widget.status} processada com sucesso',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 35),
                Text(
                  'Local: ${widget.condominio}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  'Data: $formattedDateTime',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  'Latitude: ${widget.latitude}',
                  //widget.currentLocation,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  'Longitude: ${widget.longitude}',
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
