import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String? email;

  @observable
  String? pass;

  @observable
  bool loading = false;

  @observable
  String? error;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPass(String? value) => pass = value;

  @action
  Future<void> login() async {
    loading = true;
    error = null;
    try {
      final user = await UserRepository().loginWithEmail(email!, pass!);
      GetIt.I<UserManagerStore>().setUser(user);
    } catch (e) {
      error = e.toString();
    }
    loading = false;
  }

  @computed
  bool get emailValid => email != null && email.isEmailValid();

  String? get emailError {
    if (email == null || emailValid) {
      return null;
    } else {
      return "E-mail inválido";
    }
  }

  @computed
  bool get passValid => pass != null && pass!.length >= 6;

  String? get passError {
    if (pass == null || passValid) {
      return null;
    } else {
      return "Senha inválida";
    }
  }

  @computed
  bool get isFormValid => emailValid && passValid;

  @computed
  dynamic get loginPressed =>
      emailValid && passValid && !loading ? login : null;
}
