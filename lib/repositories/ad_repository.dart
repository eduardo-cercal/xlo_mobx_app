import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:path/path.dart' as path;
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class AdRepository {
  Future<List<Ad>> getHomeAdList(
      {FilterStore? filterStore,
      String? search,
      Category? category,
      required int page}) async {
    try {
      final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyAdTable));

      queryBuilder.includeObject([keyAdOwner, keyAdCategory]);
      queryBuilder.setAmountToSkip(page * 20);
      queryBuilder.setLimit(20);
      queryBuilder.whereEqualTo(keyAdStatus, AdStatus.active.index);
      if (search != null && search.trim().isNotEmpty) {
        queryBuilder.whereContains(keyAdTitle, search, caseSensitive: false);
      }
      if (category != null && category.id != "*") {
        queryBuilder.whereEqualTo(
          keyAdCategory,
          (ParseObject(keyCategoryTable)..set(keyCategoryId, category.id))
              .toPointer(),
        );
      }
      switch (filterStore?.orderBy) {
        case OrderBy.price:
          queryBuilder.orderByAscending(keyAdPrice);
          break;
        case OrderBy.date:
        default:
          queryBuilder.orderByDescending(keyAdCreatedAt);
          break;
      }
      if (filterStore!.minPrice != null && filterStore.minPrice! > 0) {
        queryBuilder.whereGreaterThanOrEqualsTo(
            keyAdPrice, filterStore.minPrice);
      }
      if (filterStore.maxPrice != null && filterStore.maxPrice! > 0) {
        queryBuilder.whereLessThanOrEqualTo(keyAdPrice, filterStore.maxPrice);
      }
      if (filterStore.vendorType > 0 &&
          filterStore.vendorType <
              (vendorTypeProfessional | vendorTypeParticular)) {
        final userQuery = QueryBuilder<ParseUser>(ParseUser.forQuery());
        if (filterStore.vendorType == vendorTypeParticular) {
          userQuery.whereEqualTo(keyUserType, UserType.particular.index);
        }
        if (filterStore.vendorType == vendorTypeProfessional) {
          userQuery.whereEqualTo(keyUserType, UserType.professional.index);
        }
        queryBuilder.whereMatchesQuery(keyAdOwner, userQuery);
      }
      final response = await queryBuilder.query();
      if (response.success && response.results != null) {
        return response.results!.map((po) => Ad.fromParse(po)).toList();
      } else if (response.success && response.results == null) {
        return [];
      } else {
        return Future.error(ParseErrors.getDescription(response.error!.code));
      }
    } catch (e) {
      return Future.error("Falha de conexao");
    }
  }

  Future<void> save(Ad ad) async {
    try {
      final parseImages = await saveImages(ad.images);
      final parseUser = await ParseUser.currentUser();
      final adObject = ParseObject(keyAdTable);
      final parseAcl = ParseACL(owner: parseUser);

      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: false);
      adObject.setACL(parseAcl);

      if (ad.id != null) {
        adObject.set<String>(keyAdId, ad.id!);
      }
      adObject.set<String>(keyAdTitle, ad.title);
      adObject.set<String>(keyAdDescription, ad.description);
      adObject.set<bool>(keyAdHidePhone, ad.hidePhone);
      adObject.set<num>(keyAdPrice, ad.price);
      adObject.set<int>(keyAdStatus, ad.status.index);
      adObject.set<String>(keyAdDistrict, ad.address.district);
      adObject.set<String>(keyAdCity, ad.address.city.name);
      adObject.set<String>(keyAdFederativeUnit, ad.address.uf.initials);
      adObject.set<String>(keyAdPostalCode, ad.address.cep);
      adObject.set<List<ParseFile>>(keyAdImages, parseImages);
      adObject.set<ParseUser>(keyAdOwner, parseUser);
      adObject.set(keyAdCategory,
          ParseObject(keyCategoryTable)..set(keyCategoryId, ad.category.id));

      final response = await adObject.save();

      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error!.code));
      }
    } catch (e) {
      return Future.error("Falha ao salvar o anúncio!");
    }
  }

  Future<List<ParseFile>> saveImages(List images) async {
    final parseImages = <ParseFile>[];

    try {
      for (final image in images) {
        if (image is String) {
          final parseFile = ParseFile(File(path.basename(image)));
          parseFile.name = path.basename(image);
          parseFile.url = image;
          parseImages.add(parseFile);
        } else {
          final parseFile = ParseFile(image, name: path.basename(image.path));
          final response = await parseFile.save();
          if (!response.success) {
            return Future.error(
                ParseErrors.getDescription(response.error!.code));
          }
          parseImages.add(parseFile);
        }
      }
      return parseImages;
    } catch (e) {
      return Future.error("Falha ao salvar imagens");
    }
  }

  Future<List<Ad>> getMyAds(User user) async {
    final currentUser = await ParseUser.currentUser();
    final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyAdTable));

    queryBuilder.setLimit(100);
    queryBuilder.orderByDescending(keyAdCreatedAt);
    queryBuilder.whereEqualTo(keyAdOwner, currentUser.toPointer());
    queryBuilder.includeObject([keyAdCategory, keyAdOwner]);

    final response = await queryBuilder.query();
    if (response.success && response.results != null) {
      return response.results!.map((po) => Ad.fromParse(po)).toList();
    } else if (response.success && response.results == null) {
      return [];
    } else {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  Future<void> sold(Ad ad) async {
    final parseObject = ParseObject(keyAdTable)..set(keyAdId, ad.id);

    parseObject.set(keyAdStatus, AdStatus.sold.index);

    final response = await parseObject.save();
    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  Future<void> delete(Ad ad) async {
    final parseObject = ParseObject(keyAdTable)..set(keyAdId, ad.id);

    parseObject.set(keyAdStatus, AdStatus.deleted.index);

    final response = await parseObject.save();
    if (!response.success) {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }
}
