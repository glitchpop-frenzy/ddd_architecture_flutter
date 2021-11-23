import 'package:bloc/bloc.dart';
import 'package:ddd_architecture_flutter/domain/auth/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/auth/auth_failure.dart';
import '../../../../domain/auth/i_auth_facade.dart';
part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

part 'sign_in_form_bloc.freezed.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial());

  SignInFormState get initialState => SignInFormState.initial();

  // the following function will help us in
  // converting the possible events into the resultant states.
  Stream<SignInFormState> mapEventToState(SignInFormEvent event) async* {
    yield* event.map(
      emailChanged: (e) async* {
        yield state.copyWith(
            emailAddress: EmailAddress(e.emailStr),
            // we set authFailureOrSuccessOption to none() cuz
            // we don't want any previous error to have any effect on
            // and association with the currently changed input email address.
            authFailureOrSuccessOption: none());
      },
      passwordChanged: (e) async* {
        yield state.copyWith(
            password: Password(e.passwordStr),
            authFailureOrSuccessOption: none());
      },
      signInWithEmailAndPasswordPressed: (e) async* {
        yield* _performActionOnAuthFacadeWithEmailAndPassword(
            _authFacade.signInWithEmailAndPassword);
      },
      registerWithEmailAndPasswordPressed: (e) async* {
        yield* _performActionOnAuthFacadeWithEmailAndPassword(
            _authFacade.registerWithEmailAndPassword);
      },
      signInWithGooglePressed: (e) async* {
        // just when the button is pressed we will
        // reset all the previous failures
        yield state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        );
        final failureOrSuccess = await _authFacade.signInWithGoogle();
        // now, after calling the authFacade we'll see if it'll be
        // success or not.
        yield state.copyWith(
          isSubmitting: false,
          authFailureOrSuccessOption: some(failureOrSuccess),
        );
      },
    );
  }

  Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPassword(
    Future<Either<AuthFailure, Unit>> Function({
      required EmailAddress emailAddress,
      required Password password,
    })
        forwardedCall,
  ) async* {
    Either<AuthFailure, Unit>? failureOrSuccess;
    // first we make sure that the value is valid
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();
    if (isEmailValid && isPasswordValid) {
      yield state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      );
      failureOrSuccess = await forwardedCall(
        emailAddress: state.emailAddress,
        password: state.password,
      );
    }
    yield state.copyWith(
        isSubmitting: false,
        showErrorMessages: true,
        authFailureOrSuccessOption:
            // instead of doing this
            // failureOrSuccess == null ? none() : some(failureOrSuccess),
            // we can do
            optionOf(failureOrSuccess));
  }
}
