import 'package:flutter/material.dart';
import 'package:flutter_final_project/types/menu.dart';
import 'package:flutter_final_project/utils/constants.dart';

class PrincipalWidget extends StatelessWidget {
  PrincipalWidget({super.key});

  final List<Menu> menus = [
    Menu("Condominios", "Lista de Condominios", "assets/images/logo-icon.png",
        "/books")
  ];

  final title = const Text("Registro de ponto");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        backgroundColor: Color(0xFFFB7833),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            final menu = menus[index];

            return ListTile(
              leading: Image.asset(menu.icon),
              title: Text(menu.title),
              subtitle: Text(menu.subtitle),
              // trailing: nextIcon,
              trailing: nextIcon,
              onTap: () {
                Navigator.pushNamed(context, menu.path);
              },
            );
          },
          separatorBuilder: (context, index) {
            //return divider;
            return divider;
          },
          itemCount: menus.length),
    );
  }
}
