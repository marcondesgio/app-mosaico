import 'package:flutter/material.dart';
import 'package:mosaico/home/home_page.dart';
import 'package:mosaico/utils/usertype_page.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(context),
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserType type = UserType.adm;

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: Image.asset('assets/logo.jpg'),
            ),
          ),
        ),
        const Center(
          child: Text(
            'Bem-vindo ao Espaço Mosaico,\ndigite seu usuário e senha.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: MediaQuery.of(context).size.height / 1.5,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(children: [
              Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            label: Text('Digite o usuário'),
                            icon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ))),
                  )),
              const SizedBox(height: 20),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          label: Text('Digite a senha'),
                          icon: Icon(
                            Icons.key,
                            color: Colors.grey,
                          ))),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 58,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: const Center(
                    child: Text(
                      'ACESSAR',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                onTap: () {
                  if (verify()) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomePage(
                              user: type,
                            )));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.only(
                            left: 12,
                            right: 24,
                            bottom: 24,
                          ),
                          padding: EdgeInsets.zero,
                          content: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.cancel,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Text(
                                    'Usuário e senha inválidos, tente novamente.',
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          duration: const Duration(seconds: 10),
                        ))
                        .closed
                        .then((_) {});
                  }
                },
              )
            ]),
          ),
        )
      ],
    );
  }

  bool verify() {
    if (nameController.text == 'admin' && passwordController.text == 'admin') {
      type = UserType.adm;
      return true;
    } else if (nameController.text == 'resp' && passwordController.text == 'resp') {
      type = UserType.responsible;
      return true;
    } else if (nameController.text == 'prof' && passwordController.text == 'prof') {
      type = UserType.professional;
      return true;
    } else {
      return false;
    }
  }
}
