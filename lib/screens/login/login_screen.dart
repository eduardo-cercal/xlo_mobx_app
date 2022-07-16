import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/screens/signup/components/error_box.dart';
import 'package:xlo_mobx/stores/login_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import '../signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore loginStore = LoginStore();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  void initState() {
    super.initState();
    when((_) => userManagerStore.user != null, () {
      Navigator.of(context).pop(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entrar"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Acessar com E-mail:"),
                    Observer(builder: (_) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ErrorBox(
                          message: loginStore.error,
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 3,
                        bottom: 4,
                        top: 8,
                      ),
                      child: Text(
                        "E-mail",
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !loginStore.loading,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: loginStore.emailError),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: loginStore.setEmail,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 3,
                        bottom: 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Senha",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              "Esqueceu sua senha?",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !loginStore.loading,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: loginStore.passError),
                        obscureText: true,
                        onChanged: loginStore.setPass,
                      );
                    }),
                    Observer(builder: (_) {
                      return Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 12),
                        height: 40,
                        child: ElevatedButton(
                          child: loginStore.loading
                              ? const CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : const Text("ENTRAR"),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.resolveWith(
                                  (states) => RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              elevation: MaterialStateProperty.resolveWith(
                                  (states) => 0),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                (states) => loginStore.isFormValid
                                    ? Theme.of(context).primaryColor
                                    : Colors.deepPurple[400],
                              )),
                          onPressed: loginStore.loginPressed,
                        ),
                      );
                    }),
                    const Divider(
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            "Não tem uma conta? ",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                            },
                            child: Text(
                              "Cadastre-se",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
