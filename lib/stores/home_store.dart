import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/connectivity_store.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final ConnectivityStore connectivityStore=GetIt.I<ConnectivityStore>();

  _HomeStore() {
    autorun((_) async {
      connectivityStore.connected;
      try {
        setLoading(true);
        final newAds = await AdRepository().getHomeAdList(
            filterStore: filterStore,
            search: search,
            category: category,
            page: page);
        addNewAds(newAds);
        setError(null);
        setLoading(false);
      } catch (e) {
        setError(e.toString());
      }
    });
  }

  @observable
  String search = "";

  @observable
  Category? category;

  @observable
  FilterStore filterStore = FilterStore();

  ObservableList adList = ObservableList<Ad>();

  @observable
  String? error;

  @observable
  bool loading = false;

  @observable
  int page = 0;

  @observable
  bool lastPage = false;

  @action
  void addNewAds(List<Ad> newAds) {
    if (newAds.length < 20) {
      lastPage = true;
    }
    adList.addAll(newAds);
  }

  @action
  void setPage() => page++;

  @action
  void setLoading(bool value) => loading = value;

  @action
  void setError(String? value) => error = value;

  @action
  void setSearch(String value) {
    search = value;
    resetPage();
  }

  @action
  void setCategory(Category value) {
    category = value;
    resetPage();
  }

  @action
  void setFilter(FilterStore value) {
    filterStore = value;
    resetPage();
  }

  @computed
  int get itemCount => lastPage ? adList.length : adList.length + 1;

  @computed
  bool get showProgress => loading && adList.isEmpty;

  FilterStore get clonedFilter => filterStore.clone();

  void resetPage() {
    page = 0;
    adList.clear();
    lastPage = false;
  }
}
