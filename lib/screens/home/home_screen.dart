import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/screens/home/components/ad_tile.dart';
import 'package:xlo_mobx/screens/home/components/create_ad_button.dart';
import 'package:xlo_mobx/screens/home/components/search_dialog.dart';
import 'package:xlo_mobx/screens/home/components/top_bar.dart';
import 'package:xlo_mobx/screens/my_ads/components/empty_card.dart';
import 'package:xlo_mobx/stores/home_store.dart';
import 'package:xlo_mobx/widgets/custom_drawer/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeStore homeStore = GetIt.I<HomeStore>();

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Observer(
            builder: (_) {
              if (homeStore.search.isEmpty) {
                return Container();
              } else {
                return GestureDetector(
                  child: LayoutBuilder(
                    builder: (_, constraints) {
                      return Container(
                        width: constraints.biggest.width,
                        child: Text(homeStore.search),
                      );
                    },
                  ),
                  onTap: () => openSearch(context),
                );
              }
            },
          ),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            Observer(builder: (_) {
              if (homeStore.search.isEmpty) {
                return IconButton(
                  onPressed: () {
                    openSearch(context);
                  },
                  icon: const Icon(Icons.search),
                );
              } else {
                return IconButton(
                  onPressed: () {
                    homeStore.setSearch("");
                  },
                  icon: const Icon(Icons.close),
                );
              }
            })
          ],
        ),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            TopBar(),
            Expanded(
              child: Stack(
                children: [
                  Observer(
                    builder: (_) {
                      if (homeStore.error != null) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.error,
                              color: Colors.white,
                              size: 100,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Ocorreu um erro!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        );
                      }
                      if (homeStore.showProgress) {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        );
                      }
                      if (homeStore.adList.isEmpty) {
                        return const EmptyCard(text: "Nenhum anúncio encontrado.");
                      }
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: homeStore.itemCount,
                        itemBuilder: (_, index) {
                          if (index < homeStore.adList.length) {
                            return AdTile(ad: homeStore.adList[index]);
                          } else {
                            homeStore.setPage();
                            return LinearProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                  Theme.of(context).primaryColor),
                            );
                          }
                        },
                      );
                    },
                  ),
                  Positioned(
                    bottom: -50,
                    left: 0,
                    right: 0,
                    child: CreateAdButton(
                      scrollController: scrollController,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  openSearch(BuildContext context) async {
    final search = await showDialog(
        context: context,
        builder: (_) => SearchDialog(
              currentSearch: homeStore.search,
            ));

    if (search != null) {
      homeStore.setSearch(search);
    }
  }
}
