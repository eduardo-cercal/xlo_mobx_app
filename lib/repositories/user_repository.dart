import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';

class UserRepository {
  Future<User> signUp(User user) async {
    final parseUser = ParseUser(user.email, user.pass, user.email);
    parseUser.set<String>(keyUserName, user.name);
    parseUser.set<String>(keyUserPhone, user.phone);
    parseUser.set(keyUserType, user.type.index);

    final response = await parseUser.signUp();

    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  Future<User> loginWithEmail(String email, String pass) async {
    final parseUser = ParseUser(email, pass, null);
    final response = await parseUser.login();

    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error!.code));
    }
  }

  Future<User?> currentUser() async {
    final parseUser = await ParseUser.currentUser();
    if (parseUser != null) {
      final response =
          await ParseUser.getCurrentUserFromServer(parseUser.sessionToken);
      if (response!.success) {
        return mapParseToUser(response.result);
      } else {
        await parseUser.logout();
      }
    }
    return null;
  }

  User mapParseToUser(ParseUser parseUser) {
    return User(
      id: parseUser.objectId!,
      name: parseUser.get<String>(keyUserName)!,
      email: parseUser.get<String>(keyUserEmail),
      phone: parseUser.get<String>(keyUserPhone)!,
      type: UserType.values[parseUser.get<int>(keyUserType)!],
      createdAt: parseUser.get<DateTime>(keyUserCreatedAt),
    );
  }

  Future<void> save(User user) async {
    final ParseUser parseUser = await ParseUser.currentUser();

    parseUser.set(keyUserName, user.name);
    parseUser.set(keyUserPhone, user.phone);
    parseUser.set(keyUserType, user.type.index);
    if (user.pass != null) {
      parseUser.password = user.pass!;
    }

    final response = await parseUser.save();

    if (!response.success) {
      return Future.error(response.error!.code);
    }

    if (user.pass != null) {
      await parseUser.logout();
      final loginResponse =
          await ParseUser(user.email, user.pass, user.email).login();

      if (!loginResponse.success) {
        return Future.error(response.error!.code);
      }
    }
  }

  Future<void> logout() async {
    final ParseUser currentUser = await ParseUser.currentUser();
    await currentUser.logout();
  }
}
