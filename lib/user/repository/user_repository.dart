import 'dart:async';

import 'package:food_store/user/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

class UserRepository {
  User? _user;

  Future<void> setUser(User user) async {
    _user = user;
    final SharedPreferencesWithCache prefsWithCache =
        await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        // When an allowlist is included, any keys that aren't included cannot be used.
        allowList: <String>{'id', 'name', 'email', 'token'},
      ),
    );
    await prefsWithCache.setString('id', user.id);
    await prefsWithCache.setString('name', user.name);
    await prefsWithCache.setString('email', user.email);
    await prefsWithCache.setString('token', user.token);
  }

  Future<User?> getUser() async {
    final SharedPreferencesWithCache prefsWithCache =
        await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        // When an allowlist is included, any keys that aren't included cannot be used.
        allowList: <String>{'id', 'name', 'email', 'token'},
      ),
    );
    final id = prefsWithCache.getString('id');
    final name = prefsWithCache.getString('name');
    final email = prefsWithCache.getString('email');
    final token = prefsWithCache.getString('token');
    if (id != null && name != null && email != null && token != null) {
      _user = User(
        id: id,
        name: name,
        email: email,
        token: token,
      );
    }
    return _user;
  }

  Future<void> clearUser() async {
    _user = null;
    final SharedPreferencesWithCache prefsWithCache =
        await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        // When an allowlist is included, any keys that aren't included cannot be used.
        allowList: <String>{'id', 'name', 'email', 'token'},
      ),
    );
    await prefsWithCache.remove('id');
    await prefsWithCache.remove('name');
    await prefsWithCache.remove('email');
    await prefsWithCache.remove('token');
  }
}
