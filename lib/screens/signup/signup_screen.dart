import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/signup/components/error_box.dart';
import 'package:xlo_mobx/screens/signup/components/field_title.dart';
import 'package:xlo_mobx/stores/signup_store.dart';

class SignUpScreen extends StatelessWidget {
  final SignupStore signupStore = SignupStore();

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar"),
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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Observer(builder: (_){
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ErrorBox(
                          message: signupStore.error
                        ),
                      );
                    }),
                    const FieldTitle(
                      title: "Apelido",
                      subTitle: "Como aparacerá em seu anúncios.",
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Exemplo: João S",
                          isDense: true,
                          errorText: signupStore.nameError,
                        ),
                        onChanged: signupStore.setName,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    const FieldTitle(
                      title: "E-mail",
                      subTitle: "Eviaremos um e-mail de confirmação",
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Exemplo: joao@gmail.com",
                          isDense: true,
                          errorText: signupStore.emailError,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        onChanged: signupStore.setEmail,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    const FieldTitle(
                      title: "Celular",
                      subTitle: "Proteja sua conta",
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Exemplo: (99) 99999-9999",
                          isDense: true,
                          errorText: signupStore.phoneError,
                        ),
                        keyboardType: TextInputType.phone,
                        onChanged: signupStore.setPhone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter()
                        ],
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    const FieldTitle(
                      title: "Senha",
                      subTitle: "Use letras, números e caracteres especiais",
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: signupStore.pass1Error),
                        obscureText: true,
                        onChanged: signupStore.setPass1,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    const FieldTitle(
                      title: "Confirmar Senha",
                      subTitle: "Repita a senha",
                    ),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: signupStore.pass2Error),
                        obscureText: true,
                        onChanged: signupStore.setPass2,
                      );
                    }),
                    Observer(builder: (_) {
                      return Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 12),
                        height: 40,
                        child: ElevatedButton(
                          child: signupStore.loading
                              ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                              : const Text("CADASTRAR"),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.resolveWith((states) =>
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            elevation: MaterialStateProperty.resolveWith(
                                (states) => 0),
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => signupStore.isFormValid
                                    ? Theme.of(context).primaryColor
                                    : Colors.deepPurple[400]),
                          ),
                          onPressed: signupStore.signUpPressed,
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
                            onTap: Navigator.of(context).pop,
                            child: Text(
                              "Entrar",
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
