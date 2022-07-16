import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/screens/create/components/cep_field.dart';
import 'package:xlo_mobx/screens/create/components/hide_phone_field.dart';
import 'package:xlo_mobx/screens/create/components/images_field.dart';
import 'package:xlo_mobx/screens/my_ads/my_ads_screen.dart';
import 'package:xlo_mobx/screens/signup/components/error_box.dart';
import 'package:xlo_mobx/stores/create_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';
import 'package:xlo_mobx/widgets/custom_drawer/custom_drawer.dart';

import 'components/category_field.dart';

class CreateScreen extends StatefulWidget {
  final Ad? ad;

  const CreateScreen({Key? key, this.ad}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState(ad: ad);
}

class _CreateScreenState extends State<CreateScreen> {
  final CreateStore createStore;
  final bool editing;

  _CreateScreenState({Ad? ad})
      : createStore = CreateStore(ad),
        editing = ad != null;

  @override
  void initState() {
    super.initState();

    when((_) => createStore.savedAd, () {
      if (editing) {
        GetIt.I<PageStore>().setPage(0);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const MyAdsScreen()));
      } else {
        GetIt.I<PageStore>().setPage(0);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const MyAdsScreen(
                  initialPage: 1,
                )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(
      fontWeight: FontWeight.w800,
      color: Colors.grey,
      fontSize: 18,
    );
    const contentPadding = EdgeInsets.fromLTRB(16, 10, 12, 10);

    return Scaffold(
      drawer: editing ? null : const CustomDrawer(),
      appBar: AppBar(
        title: Text(editing ? "Editar Anúncio" : "Criar Anúncio"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Observer(builder: (_) {
              if (createStore.loading) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Salvando Anúncio",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImagesField(
                      createStore: createStore,
                    ),
                    Observer(builder: (_) {
                      return TextFormField(
                        initialValue: createStore.title,
                        onChanged: createStore.setTitle,
                        decoration: InputDecoration(
                            labelText: "Título *",
                            labelStyle: labelStyle,
                            contentPadding: contentPadding,
                            errorText: createStore.titleError),
                      );
                    }),
                    Observer(builder: (_) {
                      return TextFormField(
                        initialValue: createStore.description,
                        onChanged: createStore.setDescription,
                        decoration: InputDecoration(
                            labelText: "Descrição *",
                            labelStyle: labelStyle,
                            contentPadding: contentPadding,
                            errorText: createStore.descriptionError),
                        maxLines: null,
                      );
                    }),
                    CategoryField(createStore: createStore),
                    CepField(createStore: createStore),
                    Observer(builder: (_) {
                      return TextFormField(
                        initialValue: createStore.priceText,
                        onChanged: createStore.setPriceText,
                        decoration: InputDecoration(
                            labelText: "Preço *",
                            labelStyle: labelStyle,
                            contentPadding: contentPadding,
                            prefixText: "R\$ ",
                            errorText: createStore.priceError),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CentavosInputFormatter(),
                        ],
                      );
                    }),
                    HidePhoneField(createStore: createStore),
                    Observer(builder: (_) {
                      return ErrorBox(
                        message: createStore.error,
                      );
                    }),
                    Observer(builder: (_) {
                      return SizedBox(
                        height: 50,
                        child: GestureDetector(
                          onTap: createStore.invalidSendPressed,
                          child: ElevatedButton(
                            onPressed: createStore.sendPressed,
                            child: const Text(
                              "Enviar",
                              style: TextStyle(fontSize: 18),
                            ),
                            style: ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              elevation: MaterialStateProperty.resolveWith(
                                  (states) => 0),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                (states) => createStore.formValid
                                    ? Theme.of(context).primaryColor
                                    : Colors.deepPurple.withAlpha(150),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
