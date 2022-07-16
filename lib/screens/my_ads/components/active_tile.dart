import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/screens/ad/ad_screen.dart';
import 'package:xlo_mobx/screens/create/create_screen.dart';
import 'package:xlo_mobx/stores/my_ads_store.dart';

class ActiveTile extends StatelessWidget {
  final Ad ad;
  final MyAdsStore store;
  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: "Editar", iconData: Icons.edit),
    MenuChoice(index: 1, title: "Já vendi", iconData: Icons.thumb_up),
    MenuChoice(index: 2, title: "Excluir", iconData: Icons.delete)
  ];

  ActiveTile({Key? key, required this.ad, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AdScreen(ad: ad)));
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: SizedBox(
          height: 80,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: ad.images.first,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ad.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        ad.price.formattedMoney(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "${ad.views} visitas",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              PopupMenuButton<MenuChoice>(
                onSelected: (choice) {
                  switch (choice.index) {
                    case 0:
                      editAd(context);
                      break;
                    case 1:
                      soldAd(context);
                      break;
                    case 2:
                      deleteAd(context);
                      break;
                  }
                },
                itemBuilder: (_) {
                  return choices
                      .map((choice) => PopupMenuItem<MenuChoice>(
                            value: choice,
                            child: Row(
                              children: [
                                Icon(
                                  choice.iconData,
                                  size: 20,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  choice.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editAd(BuildContext context) async {
    final success = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CreateScreen(ad: ad)));
    if (success != null && success) {
      store.refresh();
    }
  }

  Future<void> soldAd(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Vendido"),
        content: Text("Confirmar a venda de ${ad.title} ?"),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(
              "Não",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              store.soldAd(ad);
            },
            child: const Text(
              "Sim",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> deleteAd(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Excluir"),
        content: Text("Confirmar a exclusão de ${ad.title} ?"),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: Text(
              "Não",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              store.deleteAd(ad);
            },
            child: const Text(
              "Sim",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuChoice {
  final int index;
  final String title;
  final IconData iconData;

  MenuChoice(
      {required this.index, required this.title, required this.iconData});
}
