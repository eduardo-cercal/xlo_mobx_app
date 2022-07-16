import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  _CreateStore(Ad? ad) {
    if (ad != null) {
      id = ad.id;
      title = ad.title;
      description = ad.description;
      images = ad.images.asObservable();
      category = ad.category;
      priceText = ad.price.toStringAsFixed(2);
      hidePhone = ad.hidePhone;
      cepStore = CepStore(ad.address.cep);
      status = ad.status;
    }
  }

  ObservableList images = ObservableList();

  CepStore cepStore = CepStore(null);

  String? id;

  AdStatus? status;

  @observable
  Category? category;

  @observable
  bool? hidePhone = false;

  @observable
  String title = "";

  @observable
  String description = "";

  @observable
  String priceText = "";

  @observable
  bool showErrors = false;

  @observable
  bool loading = false;

  @observable
  String? error;

  @observable
  bool savedAd = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @action
  void setPriceText(String value) => priceText = value;

  @action
  void setDescription(String value) => description = value;

  @action
  void setTitle(String value) => title = value;

  @action
  void setHidePhone(bool? value) => hidePhone = value;

  @action
  void setCategory(Category value) => category = value;

  @action
  Future<void> send() async {
    final ad = Ad(
      id: id,
      images: images,
      title: title,
      description: description,
      category: category!,
      address: address!,
      price: price!,
      hidePhone: hidePhone!,
      user: GetIt.I<UserManagerStore>().user!,
      status: status ?? AdStatus.pending,
    );

    loading = true;
    try {
      await AdRepository().save(ad);
      //successo
      savedAd = true;
    } catch (e) {
      error = e.toString();
    }
    loading = false;
  }

  @computed
  bool get imagesValid => images.isNotEmpty;

  String? get imagesError {
    if (!showErrors || imagesValid) {
      return null;
    } else {
      return "Insira imagens";
    }
  }

  @computed
  bool get titleValid => title.length >= 6;

  String? get titleError {
    if (!showErrors || titleValid) {
      return null;
    } else if (title.isEmpty) {
      return "Campo obrigatório";
    } else {
      return "Título muito curto";
    }
  }

  @computed
  bool get descriptionValid => description.length >= 10;

  String? get descriptionError {
    if (!showErrors || descriptionValid) {
      return null;
    } else if (description.isEmpty) {
      return "Campo obrigatório";
    } else {
      return "Descrição muito curta";
    }
  }

  @computed
  bool get categoryValid => category != null;

  String? get categoryError {
    if (!showErrors || categoryValid) {
      return null;
    } else {
      return "Campo Obrigatório";
    }
  }

  @computed
  Address? get address => cepStore.address;

  bool get addressValid => address != null;

  String? get addressError {
    if (!showErrors || addressValid) {
      return null;
    } else {
      return "Campo obrigatório";
    }
  }

  @computed
  num? get price {
    if (priceText.contains(",")) {
      return num.tryParse(priceText.replaceAll(RegExp("[^0-9]"), ""))! / 100;
    } else {
      return num.tryParse(priceText);
    }
  }

  bool get priceValid => price != null && price! <= 999999;

  String? get priceError {
    if (!showErrors || priceValid) {
      return null;
    } else if (priceText.isEmpty) {
      return "Campo obrigatório";
    } else {
      return "Preço inválido";
    }
  }

  @computed
  bool get formValid =>
      imagesValid &&
      titleValid &&
      descriptionValid &&
      priceValid &&
      addressValid &&
      categoryValid;

  @computed
  dynamic get sendPressed => formValid ? send : null;
}
