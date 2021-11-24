import 'package:ddd_architecture_flutter/application/auth/sign_in_form/bloc/sign_in_form_bloc.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flushbar/flushbar.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
        listener: (context, state) {
      state.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold((failure) {
                FlushbarHelper.createError(
                  message: failure.map(
                    cancelledByUser: (_) => 'Cancelled',
                    serverError: (_) => 'Server Error',
                    emailAlreadyInUse: (_) => 'Email already in use',
                    invalidEmailAndPasswordCombination: (_) =>
                        'Invalid email and password combination',
                  ),
                ).show(context);
              }, (r) => null));
    }, builder: (context, state) {
      final signInFormBloc = context.read<SignInFormBloc>();
      return Form(
          autovalidateMode: state.showErrorMessages == true
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: ListView(
            children: [
              const Text(
                '📝',
                style: TextStyle(fontSize: 138),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                ),
                onChanged: (value) =>
                    signInFormBloc.add(SignInFormEvent.emailChanged(value)),
                validator: (_) =>
                    signInFormBloc.state.emailAddress.value.fold((f) {
                  return f.maybeMap(
                      invalidEmail: (_) => 'Invalid Email', orElse: () => null);
                }, (r) => null),
                autocorrect: false,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                ),
                obscureText: true,
                autocorrect: false,
                onChanged: (value) =>
                    signInFormBloc.add(SignInFormEvent.passwordChanged(value)),
                validator: (_) => signInFormBloc.state.password.value.fold((f) {
                  return f.maybeMap(
                      shortPassword: (_) => 'Short Password',
                      orElse: () => null);
                }, (r) => null),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        signInFormBloc.add(const SignInFormEvent
                            .signInWithEmailAndPasswordPressed());
                      },
                      child: const Text('Sign In'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        signInFormBloc.add(const SignInFormEvent
                            .registerWithEmailAndPasswordPressed());
                      },
                      child: const Text('Register'),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    signInFormBloc
                        .add(const SignInFormEvent.signInWithGooglePressed());
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  child: const Text(
                    'Sign In with Google',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ));
    });
  }
}
