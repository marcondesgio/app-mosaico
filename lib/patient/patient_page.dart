import 'package:flutter/material.dart';
import 'package:mosaico/home/drawer_home_page.dart';
import 'package:mosaico/utils/usertype_page.dart';

class PatientPage extends StatelessWidget {
  const PatientPage({Key? key, required this.user}) : super(key: key);

  Size get preferredSize => const Size.fromHeight(80);
  final UserType user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: preferredSize.height,
        centerTitle: true,
        title: const Text(
          'Pacientes',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: _body(context)),
      endDrawer: DrawerHomePage(user: user),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _report('Breno Souza Ribeiro', 'assets/patient.jpg'),
      ],
    );
  }

  Widget _report(String text, String image) {
    return Padding(
      padding: const EdgeInsets.only(right: 24, left: 24, top: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(image),
                radius: 25,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.chevron_right,
                    color: Colors.orange,
                  )),
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
