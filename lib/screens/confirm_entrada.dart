import 'package:flutter/material.dart';
import 'package:flutter_final_project/screens/exit_app.dart';
import 'package:geolocator/geolocator.dart';

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

class RegistroEntradaWidget extends StatefulWidget {
  const RegistroEntradaWidget({super.key});

  @override
  State<RegistroEntradaWidget> createState() => _RegistroEntradaWidgetState();
}

class _RegistroEntradaWidgetState extends State<RegistroEntradaWidget> {
  String _latitude = '';
  String _longitude = '';

  @override
  void initState() {
    _determinePosition().then((Position position) {
      setState(() {
        _latitude = position.latitude.toString();
        _longitude = position.longitude.toString();
      });
      print(position.latitude);
      print(position.longitude);
    });
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
                const Text(
                  'Entrada processada com sucesso',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 35),
                Text(
                  'Data: $formattedDateTime',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  'Latitude: $_latitude',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  'Longitude: $_longitude',
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
