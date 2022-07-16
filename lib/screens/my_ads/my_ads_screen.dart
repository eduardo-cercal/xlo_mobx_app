import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/my_ads/components/active_tile.dart';
import 'package:xlo_mobx/screens/my_ads/components/empty_card.dart';
import 'package:xlo_mobx/screens/my_ads/components/pending_tile.dart';
import 'package:xlo_mobx/screens/my_ads/components/sold_tile.dart';
import 'package:xlo_mobx/stores/my_ads_store.dart';

class MyAdsScreen extends StatefulWidget {
  final int? initialPage;

  const MyAdsScreen({Key? key, this.initialPage}) : super(key: key);

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  final MyAdsStore store = MyAdsStore();

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialPage ?? 0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Anuncios"),
        centerTitle: true,
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              child: Text("ATIVOS"),
            ),
            Tab(
              child: Text("PENDENTES"),
            ),
            Tab(
              child: Text("VENDIDOS"),
            ),
          ],
        ),
      ),
      body: Observer(
        builder: (_) {
          if (store.loading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          } else {
            return TabBarView(
              controller: _controller,
              children: [
                store.activeAds.isEmpty
                    ? const EmptyCard(text: "Nenhum anúncio ativo")
                    : ListView.builder(
                        itemCount: store.activeAds.length,
                        itemBuilder: (_, index) {
                          return ActiveTile(
                            ad: store.activeAds[index],
                            store: store,
                          );
                        },
                      ),
                store.pendingAds.isEmpty
                    ? const EmptyCard(text: "Nenhum anúncio pendente")
                    : ListView.builder(
                        itemCount: store.pendingAds.length,
                        itemBuilder: (_, index) {
                          return PendingTile(ad: store.pendingAds[index]);
                        },
                      ),
                store.soldAds.isEmpty
                    ? const EmptyCard(text: "Nenhum anúncio vendido")
                    : ListView.builder(
                        itemCount: store.soldAds.length,
                        itemBuilder: (_, index) {
                          return SoldTile(ad: store.soldAds[index], store: store,);
                        },
                      ),
              ],
            );
          }
        },
      ),
    );
  }
}
