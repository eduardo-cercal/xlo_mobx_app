import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/stores/home_store.dart';

part 'filter_store.g.dart';

enum OrderBy { date, price }

const vendorTypeParticular = 1 << 0;
const vendorTypeProfessional = 1 << 1;

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {
  @observable
  OrderBy orderBy;

  @observable
  int? minPrice;

  @observable
  int? maxPrice;

  @observable
  int vendorType;

  _FilterStore({
    this.orderBy = OrderBy.date,
    this.minPrice,
    this.maxPrice,
    this.vendorType = vendorTypeParticular,
  });

  @action
  void setOrderBy(OrderBy value) => orderBy = value;

  @action
  void setMinPrice(int? value) => minPrice = value;

  @action
  void setMaxPrice(int? value) => maxPrice = value;

  @action
  void selectVendorType(int value) => vendorType = value;

  void setVendorType(int type) => vendorType = vendorType | type;

  void resetVendorType(int type) => vendorType = vendorType & ~type;

  @computed
  String? get priceError =>
      maxPrice != null && minPrice != null && maxPrice! < minPrice!
          ? "Faixa de preço inválida!"
          : null;

  @computed
  bool get isTypeParticular => (vendorType & vendorTypeParticular) != 0;

  bool get isTypeProfessional => (vendorType & vendorTypeProfessional) != 0;

  @computed
  bool get isFormValid => priceError == null;

  void save() {
    GetIt.I<HomeStore>().setFilter(this as FilterStore);
  }

  FilterStore clone() {
    return FilterStore(
        orderBy: orderBy,
        minPrice: minPrice,
        maxPrice: maxPrice,
        vendorType: vendorType);
  }
}
