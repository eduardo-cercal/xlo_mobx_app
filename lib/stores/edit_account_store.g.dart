// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_account_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditAccountStore on _EditAccountStore, Store {
  Computed<bool>? _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_EditAccountStore.nameValid'))
          .value;
  Computed<bool>? _$phoneValidComputed;

  @override
  bool get phoneValid =>
      (_$phoneValidComputed ??= Computed<bool>(() => super.phoneValid,
              name: '_EditAccountStore.phoneValid'))
          .value;
  Computed<bool>? _$passValidComputed;

  @override
  bool get passValid =>
      (_$passValidComputed ??= Computed<bool>(() => super.passValid,
              name: '_EditAccountStore.passValid'))
          .value;
  Computed<bool>? _$formValidComputed;

  @override
  bool get formValid =>
      (_$formValidComputed ??= Computed<bool>(() => super.formValid,
              name: '_EditAccountStore.formValid'))
          .value;
  Computed<dynamic>? _$savePressedComputed;

  @override
  dynamic get savePressed =>
      (_$savePressedComputed ??= Computed<dynamic>(() => super.savePressed,
              name: '_EditAccountStore.savePressed'))
          .value;

  late final _$userTypeAtom =
      Atom(name: '_EditAccountStore.userType', context: context);

  @override
  UserType? get userType {
    _$userTypeAtom.reportRead();
    return super.userType;
  }

  @override
  set userType(UserType? value) {
    _$userTypeAtom.reportWrite(value, super.userType, () {
      super.userType = value;
    });
  }

  late final _$nameAtom =
      Atom(name: '_EditAccountStore.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$phoneAtom =
      Atom(name: '_EditAccountStore.phone', context: context);

  @override
  String? get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String? value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  late final _$passAtom =
      Atom(name: '_EditAccountStore.pass', context: context);

  @override
  String get pass {
    _$passAtom.reportRead();
    return super.pass;
  }

  @override
  set pass(String value) {
    _$passAtom.reportWrite(value, super.pass, () {
      super.pass = value;
    });
  }

  late final _$pass2Atom =
      Atom(name: '_EditAccountStore.pass2', context: context);

  @override
  String get pass2 {
    _$pass2Atom.reportRead();
    return super.pass2;
  }

  @override
  set pass2(String value) {
    _$pass2Atom.reportWrite(value, super.pass2, () {
      super.pass2 = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_EditAccountStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$saveAsyncAction =
      AsyncAction('_EditAccountStore.save', context: context);

  @override
  Future<void> save() {
    return _$saveAsyncAction.run(() => super.save());
  }

  late final _$_EditAccountStoreActionController =
      ActionController(name: '_EditAccountStore', context: context);

  @override
  void setUserType(int value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setUserType');
    try {
      return super.setUserType(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone(String value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setPhone');
    try {
      return super.setPhone(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPass(String value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setPass');
    try {
      return super.setPass(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPass2(String value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setPass2');
    try {
      return super.setPass2(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userType: ${userType},
name: ${name},
phone: ${phone},
pass: ${pass},
pass2: ${pass2},
loading: ${loading},
nameValid: ${nameValid},
phoneValid: ${phoneValid},
passValid: ${passValid},
formValid: ${formValid},
savePressed: ${savePressed}
    ''';
  }
}
