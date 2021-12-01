import 'package:auto_route/auto_route.dart';
import 'package:ddd_architecture_flutter/application/auth/auth/bloc/auth_bloc.dart';
import 'package:ddd_architecture_flutter/presentation/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../route/router.gr.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // listener is useful to do things which cannot happen during build
    // ex. navigation

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (ctx, state) {
        state.maybeMap(
          orElse: () {},
          unauthenticated: (_) =>
              context.router.replace(const SignInPageRoute()),
        );
      },
      builder: (ctx, state) {
        return state.maybeMap(
          orElse: () {
            // ignore: avoid_print
            print(state);
            return Container(
                color: Colors.white,
                child: const Text('Builder: Some error occured'));
          },
          initial: (_) {
            return const SignInPage();
          },
          processing: (_) {
            // ignore: avoid_print
            print('kya yeh execute ho rha hai?');
            return const Center(child: CircularProgressIndicator());
          },
          authenticated: (_) {
            // ignore:avoid_print
            print('I am authenticated');
            return const Text('The user is Authenticated');
            // context.router.push(route);
          },
        );
      },
      // child: const Scaffold(body: SignInPage()),
    );
  }
}
