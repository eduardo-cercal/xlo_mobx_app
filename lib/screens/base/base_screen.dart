import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/screens/account/account_screen.dart';
import 'package:xlo_mobx/screens/create/create_screen.dart';
import 'package:xlo_mobx/screens/home/home_screen.dart';
import 'package:xlo_mobx/stores/connectivity_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';

import '../favorites/favorites_screen.dart';
import '../offline/offline_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();
  final PageStore pageStore = GetIt.I<PageStore>();

  @override
  void initState() {
    super.initState();

    reaction(
        (_) => pageStore.page, (int page) => pageController.jumpToPage(page));

    autorun((_) {
      if (!connectivityStore.connected) {
        Future.delayed(const Duration(milliseconds: 50)).then((value) =>
            showDialog(
                context: context, builder: (_) => const OfflineScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const HomeScreen(),
          const CreateScreen(),
          Container(
            color: Colors.blue,
          ),
          FavoritesScreen(),
          const AccountScreen(),
        ],
      ),
    );
  }
}
