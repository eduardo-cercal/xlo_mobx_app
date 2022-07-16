import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/screens/my_ads/components/empty_card.dart';
import 'package:xlo_mobx/stores/favorite_store.dart';
import 'package:xlo_mobx/widgets/custom_drawer/custom_drawer.dart';

import 'components/favorite_tile.dart';

class FavoritesScreen extends StatelessWidget {
  final bool hideDrawer;
  final FavoriteStore favoriteStore = GetIt.I<FavoriteStore>();

  FavoritesScreen({Key? key, this.hideDrawer = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
      ),
      drawer: hideDrawer ? null : const CustomDrawer(),
      body: Observer(builder: (_) {
        if (favoriteStore.favoriteList.isEmpty) {
          return const EmptyCard(text: "Nenhum anúncio favorito.");
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(2),
            itemCount: favoriteStore.favoriteList.length,
            itemBuilder: (_, index) =>
                FavoriteTile(favoriteStore.favoriteList[index]),
          );
        }
      }),
    );
  }
}
