import 'package:flutter/material.dart';
import 'package:mosaico/utils/usertype_page.dart';

class DrawerHomePage extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(66);

  const DrawerHomePage({Key? key, required this.user}) : super(key: key);

  final UserType user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.blue,
        width: 300,
        child: ListView(children: [
          if (user == UserType.adm) _adm(context),
          if (user == UserType.professional) _professional(context),
          if (user == UserType.responsible) _responsible(context),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Sair',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ))
        ]));
  }

  Widget _adm(BuildContext context) {
    return Column(
      children: [
        _menuHeader('assets/logo.jpg', 'Administrador'),
        _itemMenu(Icons.calendar_month, 'Agenda', () {}),
        _itemMenu(Icons.groups, 'Colaboradores', () {}),
        _itemMenu(Icons.diversity_3, 'Pacientes', () {}),
        _itemMenu(Icons.assignment, 'Relatórios', () {})
      ],
    );
  }

  Widget _professional(BuildContext context) {
    return Column(
      children: [
        _menuHeader('assets/professional.jpg', 'Beatriz Cardoso Ferreira'),
        _itemMenu(Icons.calendar_month, 'Agenda', () {}),
        _itemMenu(Icons.diversity_3, 'Pacientes', () {}),
        _itemMenu(Icons.assignment, 'Relatórios Enviados', () {})
      ],
    );
  }

  Widget _responsible(BuildContext context) {
    return Column(
      children: [
        _menuHeader('assets/patient.jpg', 'Breno Souza Ribeiro'),
        _itemMenu(Icons.calendar_month, 'Agenda', () {}),
        _itemMenu(Icons.assignment, 'Relatórios Recebidos', () {}),
      ],
    );
  }

  Widget _menuHeader(String image, String name) {
    return Container(
      alignment: Alignment.center,
      height: 80,
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(image),
              radius: 30,
            ),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemMenu(IconData icon, String name, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    name,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
