import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'my_ads_store.g.dart';

class MyAdsStore = _MyAdsStore with _$MyAdsStore;

abstract class _MyAdsStore with Store {
  _MyAdsStore() {
    getMyAds();
  }

  @observable
  List<Ad> allAds = [];

  @observable
  bool loading = false;

  @computed
  List<Ad> get activeAds =>
      allAds.where((ad) => ad.status == AdStatus.active).toList();

  List<Ad> get pendingAds =>
      allAds.where((ad) => ad.status == AdStatus.pending).toList();

  List<Ad> get soldAds =>
      allAds.where((ad) => ad.status == AdStatus.sold).toList();

  Future<void> getMyAds() async {
    final user = GetIt.I<UserManagerStore>().user!;

    try {
      loading = true;
      allAds = await AdRepository().getMyAds(user);
      loading = false;
    } catch (e) {}
  }

  void refresh() => getMyAds();

  Future<void> soldAd(Ad ad) async{
    loading=true;
    await AdRepository().sold(ad);
    refresh();
  }

  Future<void> deleteAd(Ad ad) async{
    loading=true;
    await AdRepository().delete(ad);
    refresh();
  }
}
