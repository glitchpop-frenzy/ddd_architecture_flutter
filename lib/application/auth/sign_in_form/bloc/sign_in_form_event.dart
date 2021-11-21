part of 'sign_in_form_bloc.dart';

// In this class we define what events the User can perform
// via the UI of the application

// They are :-
// 1. Email changed.
// 2. Password field change.
// 3. Sign in with email and password.
// 4. Register with email and password.
// 5. Sign in with Google.

@freezed
abstract class SignInFormEvent with _$SignInFormEvent {
  const factory SignInFormEvent.emailChanged(String emailStr) = EmailChanged;
  const factory SignInFormEvent.passwordChanged(String passwordStr) =
      PasswordChanged;
  const factory SignInFormEvent.signInWithEmailAndPasswordPressed(
      String emailStr) = SignInWithEmailAndPasswordPressed;
  const factory SignInFormEvent.registerWithEmailAndPasswordPressed(
      String emailStr) = RegisterWithEmailAndPasswordPressed;
  const factory SignInFormEvent.signInWithGooglePressed(String emailStr) =
      SignInWithGooglePressed;
}
