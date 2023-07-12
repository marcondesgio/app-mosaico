import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: preferredSize.height,
        centerTitle: true,
        title: const Text(
          'Sobre o Espaço Mosaíco',
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
      body: SingleChildScrollView(child: _body()),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/logo.jpg'),
                radius: 30,
              ),
            ),
          ),
          const Text(
            'O Espaço Mosaico é uma clínica multidisciplinar que conta com especialistas certificados nas áreas de análise do comportamento aplicada (ABA); psicologia; neuropsicologia; psicopedagogia; neuropsicopedagogia; fonoaudiologia, fisioterapia e terapia ocupacional. Somos especialistas no atendimento de autismo, TDAH e outros transtornos do neurodesenvolvimento.',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 24, bottom: 12),
            child: Text(
              'Localização',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
          const Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.grey,
          ),
          _item(Icons.pin_drop, 'Unidade 1'),
          const SizedBox(
            height: 12,
          ),
          const Text(
            'Av. Cavalheiro José Ferrari, 415 Jardim Santo Antonio, Itatiba - SP, 13251-350',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          const SizedBox(
            height: 24,
          ),
          _item(Icons.pin_drop, 'Unidade 2'),
          const SizedBox(
            height: 12,
          ),
          const Text(
            'Rua Professor Ataliba de Oliveira, 46 Vila Prudente de Moraes, Itatiba - SP, 13251-361',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 24, bottom: 12),
            child: Text(
              'Contato',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
          const Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.grey,
          ),
          _item(Icons.smartphone, 'Celular'),
          const SizedBox(
            height: 12,
          ),
          const Text(
            '(11) 96194-1815',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          const SizedBox(
            height: 24,
          ),
          _item(Icons.call, 'Telefone'),
          const SizedBox(
            height: 12,
          ),
          const Text(
            '(11) 2570-9242',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.orange,
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.blue, fontSize: 16),
        ),
      ],
    );
  }
}
