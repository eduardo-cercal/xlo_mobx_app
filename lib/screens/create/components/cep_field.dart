import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class CepField extends StatelessWidget {
  final CepStore cepStore;
  final CreateStore createStore;

  CepField({Key? key, required this.createStore})
      : cepStore = createStore.cepStore,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Observer(builder: (_) {
          return TextFormField(
            initialValue: cepStore.cep,
            onChanged: cepStore.setCep,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ],
            decoration: InputDecoration(
              errorText: createStore.addressError,
              labelText: "CEP *",
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.grey,
                  fontSize: 18),
              contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
            ),
          );
        }),
        Observer(builder: (_) {
          if (cepStore.address == null &&
              cepStore.error == null &&
              !cepStore.loading) {
            return Container();
          } else if (cepStore.address == null && cepStore.error == null) {
            return const LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
              backgroundColor: Colors.transparent,
            );
          } else if (cepStore.error != null) {
            return Container(
              color: Colors.red.withAlpha(100),
              height: 50,
              padding: const EdgeInsets.all(8),
              child: Text(
                cepStore.error!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            );
          } else {
            final a = cepStore.address;
            return Container(
              color: Colors.deepPurple.withAlpha(150),
              height: 50,
              padding: const EdgeInsets.all(8),
              child: Text(
                "Localização: ${a!.district}, ${a.city.name} - ${a.uf.initials}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            );
          }
        }),
      ],
    );
  }
}
