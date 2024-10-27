import 'dart:async';

import 'package:food_store/user/model/user.dart';
import 'package:food_store/login/api/login_api.dart';
import 'package:food_store/signup/api/signup_api.dart';
import 'package:food_store/utilities/exceptions/authentication_exception.dart';

enum AuthenticationStatus { initial, unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository({
    required LoginApi loginApi,
    required SignupApi signupApi,
  })  : _loginApi = loginApi,
        _signupApi = signupApi;

  final LoginApi _loginApi;
  final SignupApi _signupApi;

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.initial;
    yield* _controller.stream;
  }

  Future<User?> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final responseData = await _loginApi.login(email, password);
      _controller.add(AuthenticationStatus.authenticated);
      final user = User.fromJson(responseData);
      return user;
    } catch (e) {
      if (e.runtimeType == AuthenticationException) {
        _controller.add(AuthenticationStatus.unauthenticated);
        rethrow;
      }
      _controller.add(AuthenticationStatus.unauthenticated);
      return null;
    }
  }

  Future<User?> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final responseData = await _signupApi.signup(name, email, password);
      _controller.add(AuthenticationStatus.authenticated);
      final user = User.fromJson(responseData);
      return user;
    } catch (e) {
      if (e.runtimeType == AuthenticationException) {
        _controller.add(AuthenticationStatus.unauthenticated);
        rethrow;
      }
      _controller.add(AuthenticationStatus.unauthenticated);
      return null;
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
