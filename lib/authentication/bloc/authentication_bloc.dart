import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_store/user/model/user.dart';
import 'package:food_store/user/repository/user_repository.dart';
import 'package:food_store/authentication/repository/authentication_repository.dart';
import 'package:food_store/utilities/logger/logger.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationSubscriptionRequested>(
      _onAuthenticationSubscriptionRequested,
    );
    on<AuthenticationLogoutPressed>(_onLogoutPressed);
  }

  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  Future<void> _onAuthenticationSubscriptionRequested(
    AuthenticationSubscriptionRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    logger.d('AuthenticationSubscriptionRequested');
    return emit.onEach(
      _authenticationRepository.status,
      onData: (status) async {
        logger.d('AuthenticationStatus: $status');
        try {
          switch (status) {
            case AuthenticationStatus.initial:
              final user = await _tryGetUser();
              if (user != null) {
                return emit(AuthenticationState.authenticated(user));
              }
              return emit(const AuthenticationState.unauthenticated());
            case AuthenticationStatus.unauthenticated:
              return emit(const AuthenticationState.unauthenticated());
            case AuthenticationStatus.authenticated:
              logger.d('Try get user');
              final user = await _tryGetUser();
              logger.d('User: $user');
              return emit(
                user != null
                    ? AuthenticationState.authenticated(user)
                    : const AuthenticationState.unauthenticated(),
              );
            case AuthenticationStatus.unknown:
              logger.d('Unknown');
              return emit(const AuthenticationState.unknown());

            default:
              logger.d('Default');
              return emit(const AuthenticationState.unknown());
          }
        } catch (e) {
          logger.e(e.toString());
        }
      },
      onError: addError,
    );
  }

  FutureOr<void> _onLogoutPressed(
    AuthenticationLogoutPressed event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      _authenticationRepository.logOut();
      await _userRepository.clearUser();
      emit(const AuthenticationState.unauthenticated());
    } catch (e) {
      emit(const AuthenticationState.unauthenticated());
    }
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
