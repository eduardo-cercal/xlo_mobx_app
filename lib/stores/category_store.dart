import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/category_repository.dart';

import 'connectivity_store.dart';

part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  ObservableList<Category> categoryList = ObservableList<Category>();
  @observable
  String? error;

  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  @action
  void setError(String value) => error = value;

  @action
  void setCategories(List<Category> categories) {
    categoryList.clear();
    categoryList.addAll(categories);
  }

  @computed
  List<Category> get allCategoryList => List.from(categoryList)
    ..insert(0, Category(id: '*', description: "Todas"));

  _CategoryStore() {
    autorun((_) {
      if (connectivityStore.connected) {
        loadCategories();
      }
    });
  }

  Future<void> loadCategories() async {
    try {
      final categories = await CategoryRepository().getList();
      setCategories(categories);
    } catch (e) {
      setError(e.toString());
    }
  }
}
