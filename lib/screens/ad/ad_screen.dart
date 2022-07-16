import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/screens/ad/components/bottom_bar.dart';
import 'package:xlo_mobx/screens/ad/components/description_panel.dart';
import 'package:xlo_mobx/screens/ad/components/location_panel.dart';
import 'package:xlo_mobx/screens/ad/components/main_panel.dart';
import 'package:xlo_mobx/screens/ad/components/user_panel.dart';
import 'package:xlo_mobx/stores/favorite_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

class AdScreen extends StatelessWidget {
  final Ad ad;
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final FavoriteStore favoriteStore = GetIt.I<FavoriteStore>();

  AdScreen({Key? key, required this.ad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anúncio"),
        centerTitle: true,
        actions: [
          if (ad.status == AdStatus.active && userManagerStore.isLoggedIn)
            Observer(
                builder: (_) => IconButton(
                      onPressed: () => favoriteStore.toggleFavorite(ad),
                      icon: Icon(
                        favoriteStore.favoriteList.any((a) => a.id == ad.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                    ))
        ],
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                height: 280,
                child: Carousel(
                  images: ad.images
                      .map(
                        (url) => Image(
                          image: CachedNetworkImageProvider(url),
                          fit: BoxFit.cover,
                        ),
                      )
                      .toList(),
                  dotSize: 4,
                  dotBgColor: Colors.transparent,
                  dotColor: Theme.of(context).primaryColor,
                  autoplay: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MainPanel(ad: ad),
                    Divider(
                      color: Colors.grey[500],
                    ),
                    DescriptionPanel(ad: ad),
                    Divider(
                      color: Colors.grey[500],
                    ),
                    LocationPanel(ad: ad),
                    Divider(
                      color: Colors.grey[500],
                    ),
                    UserPanel(ad: ad),
                    SizedBox(
                      height: ad.status == AdStatus.pending ? 16 : 120,
                    ),
                  ],
                ),
              ),
            ],
          ),
          BottomBar(ad: ad)
        ],
      ),
    );
  }
}
