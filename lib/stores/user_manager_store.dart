import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';

part 'user_manager_store.g.dart';

class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {
  @observable
  User? user;

  _UserManagerStore() {
    getCurrentUser();
  }

  @action
  void setUser(User? value) => user = value;

  @computed
  bool get isLoggedIn => user != null;

  Future<void> getCurrentUser() async {
    final user = await UserRepository().currentUser();
    setUser(user);
  }

  Future<void> logout() async{
    print("passei aqui");
    await UserRepository().logout();
    setUser(null);
  }
}
