import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:food_store/user/model/user.dart';
import 'package:food_store/user/repository/user_repository.dart';
import 'package:food_store/authentication/repository/authentication_repository.dart';
import 'package:food_store/login/models/email.dart';
import 'package:food_store/login/models/password.dart';
import 'package:food_store/utilities/exceptions/authentication_exception.dart';
import 'package:food_store/utilities/logger/logger.dart';
// import 'package:food_store/utilities/logger/logger.dart';
// import 'package:food_store/utilities/logger/logger.dart';
import 'package:formz/formz.dart';
// import 'package:logger/logger.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required UserRepository userRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginEmailChanged>(_onLoginEmailChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginPasswordVisibilityChanged>(_onLoginPasswordVisibilityChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  FutureOr<void> _onLoginEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  FutureOr<void> _onLoginPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  FutureOr<void> _onLoginPasswordVisibilityChanged(
    LoginPasswordVisibilityChanged event,
    Emitter<LoginState> emit,
  ) {
    final passwordHidden = !state.passwordHidden;
    // logger.d(passwordHidden);
    emit(
      state.copyWith(
        passwordHidden: passwordHidden,
      ),
    );
  }

  FutureOr<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.email.isPure && state.password.isPure) {
      // logger.d("Initial");
      final email = Email.dirty(state.email.value);
      final password = Password.dirty(state.password.value);

      var validate = Formz.validate(
        [state.email, state.password],
      );
      // logger.d(validate);
      emit(
        state.copyWith(
          email: email,
          password: password,
          isValid: validate,
        ),
      );
      return;
    }
    if (state.isValid) {
      final email = state.email.value;
      final password = state.password.value;
      try {
        emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
        final user = await _authenticationRepository.logIn(
          email: email,
          password: password,
        );
        logger.i(user);
        await _userRepository.setUser(user!);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        if (e.runtimeType == AuthenticationException) {
          var errorMessage = (e as AuthenticationException).message;
          emit(
            state.copyWith(
              errorMessage: errorMessage,
              status: FormzSubmissionStatus.failure,
            ),
          );
          return;
        }
        emit(
          state.copyWith(
            errorMessage: 'An error occured',
            status: FormzSubmissionStatus.failure,
          ),
        );
      }
    }
  }
}
