// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoriteStore on _FavoriteStore, Store {
  late final _$toggleFavoriteAsyncAction =
      AsyncAction('_FavoriteStore.toggleFavorite', context: context);

  @override
  Future<void> toggleFavorite(Ad ad) {
    return _$toggleFavoriteAsyncAction.run(() => super.toggleFavorite(ad));
  }

  late final _$_getFavoritesListAsyncAction =
      AsyncAction('_FavoriteStore._getFavoritesList', context: context);

  @override
  Future<void> _getFavoritesList() {
    return _$_getFavoritesListAsyncAction.run(() => super._getFavoritesList());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
