import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:xlo_mobx/stores/edit_account_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';

class EditAccountScreen extends StatelessWidget {
  final EditAccountStore store = EditAccountStore();

  EditAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar conta"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Observer(
                builder: (_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LayoutBuilder(builder: (_, constraints) {
                        return IgnorePointer(
                          ignoring: store.loading,
                          child: ToggleSwitch(
                            minWidth: constraints.biggest.width / 2.01,
                            labels: const ["Particular", "Profissional"],
                            cornerRadius: 20,
                            activeBgColor: [Theme.of(context).primaryColor],
                            inactiveBgColor: Colors.grey,
                            activeFgColor: Colors.white,
                            inactiveFgColor: Colors.white,
                            initialLabelIndex: store.userType!.index,
                            onToggle: (i) {
                              store.setUserType(i!);
                            },
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        enabled: !store.loading,
                        initialValue: store.name,
                        onChanged: store.setName,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            floatingLabelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                            ),
                            isDense: true,
                            labelText: "Nome*",
                            errorText: store.nameError),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        enabled: !store.loading,
                        initialValue: store.phone,
                        onChanged: store.setPhone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter()
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            floatingLabelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                            ),
                            isDense: true,
                            labelText: "Telefone*",
                            errorText: store.phoneError),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        enabled: !store.loading,
                        onChanged: store.setPass,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          floatingLabelStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          isDense: true,
                          labelText: "Nova senha",
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        onChanged: store.setPass2,
                        enabled: !store.loading,
                        obscureText: true,
                        decoration: InputDecoration(
                            floatingLabelStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                            ),
                            isDense: true,
                            labelText: "Confirmar nova senha",
                            errorText: store.passError),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: store.savePressed,
                          child: store.loading
                              ? const CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : const Text("Salvar"),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.resolveWith(
                                  (states) => RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              elevation: MaterialStateProperty.resolveWith(
                                  (states) => 0),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                (states) => store.formValid
                                    ? Theme.of(context).primaryColor
                                    : Colors.deepPurple.withAlpha(100),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: (){
                            store.logout();
                            GetIt.I<PageStore>().setPage(0);
                            Navigator.of(context).pop();
                          },
                          child: const Text("Sair"),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.resolveWith(
                                  (states) => RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              elevation: MaterialStateProperty.resolveWith(
                                  (states) => 0),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                (states) => Colors.red,
                              )),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
