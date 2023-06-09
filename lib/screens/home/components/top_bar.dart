import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/screens/category/category_screen.dart';
import 'package:xlo_mobx/screens/filter/filter_screen.dart';
import 'package:xlo_mobx/screens/home/components/bar_buttom.dart';
import 'package:xlo_mobx/stores/home_store.dart';

class TopBar extends StatelessWidget {
  final HomeStore homeStore = GetIt.I<HomeStore>();

  TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Observer(builder: (_) {
          return BarButton(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              label: homeStore.category?.description ?? "Categorias",
              onTap: () async {
                final category =
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CategoryScreen(
                              showAll: true,
                              selected: homeStore.category,
                            )));
                if (category != null) {
                  homeStore.setCategory(category);
                }
              });
        }),
        BarButton(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
                left: BorderSide(color: Colors.grey),
              ),
            ),
            label: "Filtros",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FilterScreen()));
            })
      ],
    );
  }
}
