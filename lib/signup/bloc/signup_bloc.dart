import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_store/authentication/repository/authentication_repository.dart';
import 'package:food_store/signup/models/signup_email.dart';
import 'package:food_store/signup/models/signup_name.dart';
import 'package:food_store/signup/models/signup_password.dart';
import 'package:food_store/user/repository/user_repository.dart';
import 'package:food_store/utilities/exceptions/authentication_exception.dart';
import 'package:formz/formz.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({
    required UserRepository userRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(const SignupState()) {
    on<SignupNameChanged>(_onSignupNameChanged);
    on<SignupEmailChanged>(_onSignupEmailChanged);
    on<SignupPasswordChanged>(_onSignupPasswordChanged);
    on<SignupPasswordVisibilityChanged>(_onSignupPasswordVisibilityChanged);
    on<SignupSubmitted>(_onSignupSubmitted);
  }

  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  FutureOr<void> _onSignupNameChanged(
    SignupNameChanged event,
    Emitter<SignupState> emit,
  ) {
    final name = SignupName.dirty(event.name);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([name, state.email, state.password]),
      ),
    );
  }

  FutureOr<void> _onSignupEmailChanged(
    SignupEmailChanged event,
    Emitter<SignupState> emit,
  ) {
    final email = SignupEmail.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([state.name, email, state.password]),
      ),
    );
  }

  FutureOr<void> _onSignupPasswordChanged(
    SignupPasswordChanged event,
    Emitter<SignupState> emit,
  ) {
    final password = SignupPassword.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.name, state.email, password]),
      ),
    );
  }

  FutureOr<void> _onSignupPasswordVisibilityChanged(
    SignupPasswordVisibilityChanged event,
    Emitter<SignupState> emit,
  ) {
    final passwordHidden = !state.passwordHidden;
    // logger.d(passwordHidden);
    emit(
      state.copyWith(
        passwordHidden: passwordHidden,
      ),
    );
  }

  FutureOr<void> _onSignupSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    if (state.email.isPure && state.password.isPure) {
      final name = SignupName.dirty(state.name.value);
      final email = SignupEmail.dirty(state.email.value);
      final password = SignupPassword.dirty(state.password.value);

      var validate = Formz.validate([state.name, state.email, state.password]);

      emit(
        state.copyWith(
          name: name,
          email: email,
          password: password,
          isValid: validate,
        ),
      );
      return;
    }
    if (state.isValid) {
      final name = state.name.value;
      final email = state.email.value;
      final password = state.password.value;
      try {
        emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
        final user = await _authenticationRepository.signup(
          name: name,
          email: email,
          password: password,
        );
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
