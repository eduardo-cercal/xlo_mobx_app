import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class HidePhoneField extends StatelessWidget {
  final CreateStore createStore;

  const HidePhoneField({Key? key, required this.createStore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Observer(builder: (_) {
            return Checkbox(
              value: createStore.hidePhone,
              onChanged: createStore.setHidePhone,
              activeColor: Theme.of(context).primaryColor,
            );
          }),
          const Expanded(child: Text("Ocultar meu telefone neste anúncio"))
        ],
      ),
    );
  }
}
