part of 'sign_in_form_bloc.dart';

@freezed
abstract class SignInFormState with _$SignInFormState {
  const factory SignInFormState({
    // email address is provided by the user and hence it'll be validated
    required EmailAddress emailAddress,
    // password is provided by the user and hence it'll be validated
    required Password password,
    // whether to show error messages or not
    // suppose if the user is opening the app for the firsttime
    // you don't want to throw error directly that no email address entered
    // he just entered the app hence we shouldn't show the error messages
    // until he has pressed a button
    required bool showErrorMessages,
    // whether the submission of email and password is in progress
    // (to show the loading spinner)
    required bool isSubmitting,
    // Whether the Authentication failed or did the system validate the user
    // or even if the user has pressed the button to be validated.
    // Option<None, Some> is used similar to either
    // but instead it hold either None or Some/Any value.
    required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
  }) = _SignInFormState;

  factory SignInFormState.initial() => SignInFormState(
        emailAddress: EmailAddress(''),
        password: Password(''),
        showErrorMessages: false,
        isSubmitting: false,
        authFailureOrSuccessOption: none(),
      );
}
