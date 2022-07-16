import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/repositories/category_repository.dart';
import 'package:xlo_mobx/repositories/cep_repository.dart';
import 'package:xlo_mobx/repositories/obge_repository.dart';
import 'package:xlo_mobx/screens/category/category_screen.dart';
import 'package:xlo_mobx/stores/category_store.dart';
import 'package:xlo_mobx/stores/connectivity_store.dart';
import 'package:xlo_mobx/stores/favorite_store.dart';
import 'package:xlo_mobx/stores/home_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import 'screens/base/base_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  setUpLocators();
  runApp(const MyApp());
}

void setUpLocators() {
  GetIt.I.registerSingleton(ConnectivityStore());
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(HomeStore());
  GetIt.I.registerSingleton(UserManagerStore());
  GetIt.I.registerSingleton(CategoryStore());
  GetIt.I.registerSingleton(FavoriteStore());
}

Future<void> initializeParse() async {
  await Parse().initialize("W3ZKsQcfrUW9HOHrCLkp3PhRswEGeQ8tNI2U2d3S",
      "https://parseapi.back4app.com/",
      clientKey: "Q6dUG42oDwye3DKwBBxi8Yxgmw5Ed83UkpnZMA7G",
      autoSendSessionId: true,
      debug: true);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "XLO MobX",
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          color: Colors.deepPurple,
          elevation: 0,
        ),
      ),
      supportedLocales: const [
        Locale("pt", "BR"),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      home: const BaseScreen(),
    );
  }
}
