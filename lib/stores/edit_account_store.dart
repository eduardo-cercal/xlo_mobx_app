import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'edit_account_store.g.dart';

class EditAccountStore = _EditAccountStore with _$EditAccountStore;

abstract class _EditAccountStore with Store {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  late User user;

  @observable
  UserType? userType;

  @observable
  String? name;

  @observable
  String? phone;

  @observable
  String pass = "";

  @observable
  String pass2 = "";

  @observable
  bool loading = false;

  _EditAccountStore() {
    user = userManagerStore.user!;

    userType = user.type;
    name = user.name;
    phone = user.phone;
  }

  @action
  void setUserType(int value) => userType = UserType.values[value];

  @action
  void setPhone(String value) => phone = value;

  @action
  void setName(String value) => name = value;

  @action
  void setPass(String value) => pass = value;

  @action
  void setPass2(String value) => pass2 = value;

  @action
  Future<void> save() async {
    loading = true;
    user.name = name!;
    user.phone = phone!;
    user.type = userType!;
    if (pass.isNotEmpty) {
      user.pass = pass;
    } else {
      user.pass = null;
    }
    try {
      await UserRepository().save(user);
      userManagerStore.setUser(user);
    } catch (e) {
      print(e);
    }
    loading = false;
  }

  @computed
  bool get nameValid => name != null && name!.length >= 6;

  String? get nameError =>
      nameValid || name == null ? null : "Campo obrigatório";

  @computed
  bool get phoneValid => phone != null && phone!.length >= 14;

  String? get phoneError =>
      phoneValid || phone == null ? null : "Campo obrigatório";

  @computed
  bool get passValid => pass == pass2 && (pass.length >= 6 || pass.isEmpty);

  String? get passError {
    if (pass.isNotEmpty && pass.length < 6) {
      return "Senha muito curta";
    } else if (pass != pass2) {
      return "Senhas não coincidem";
    } else {
      return null;
    }
  }

  @computed
  bool get formValid => nameValid && phoneValid && passValid;

  @computed
  dynamic get savePressed => (formValid && !loading) ? save : null;

  Future<void> logout() async => userManagerStore.logout();
}
