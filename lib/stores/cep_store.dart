import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/repositories/cep_repository.dart';

part 'cep_store.g.dart';

class CepStore = _CepStore with _$CepStore;

abstract class _CepStore with Store {
  @observable
  String cep = "";

  @observable
  Address? address;

  @observable
  String? error;

  @observable
  bool loading = false;

  _CepStore(String? initialCep) {
    autorun((_) {
      if (clearCep.length != 8) {
        reset();
      } else {
        searchCep();
      }
    });

    if (initialCep != null) {
      setCep(initialCep);
    }
  }

  @action
  void setCep(String value) => cep = value;

  @computed
  String get clearCep => cep.replaceAll(RegExp("[^0-9]"), "");

  @action
  Future<void> searchCep() async {
    loading = true;
    try {
      address = await CepRepository().getAddressFromApi(clearCep);
    } catch (e) {
      error = e.toString();
    }
    loading = false;
  }

  @action
  void reset() {
    address = null;
    error = null;
  }
}
