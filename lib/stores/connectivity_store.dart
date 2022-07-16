import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobx/mobx.dart';

part 'connectivity_store.g.dart';

class ConnectivityStore = _ConnectivityStore with _$ConnectivityStore;

abstract class _ConnectivityStore with Store {
  _ConnectivityStore() {
    _setupListener();
  }

  Future<void> _setupListener() async {
    final connection = await Connectivity().checkConnectivity();
    setConnected(connection != ConnectivityResult.none);

    Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        setConnected(true);
      } else {
        setConnected(false);
      }
    });
  }

  @observable
  bool connected = true;

  @action
  void setConnected(bool value) => connected = value;
}
