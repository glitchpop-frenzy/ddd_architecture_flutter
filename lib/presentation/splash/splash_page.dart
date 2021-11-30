import 'package:auto_route/auto_route.dart';
import 'package:ddd_architecture_flutter/application/auth/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../route/router.gr.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // listener is useful to do things which cannot happen during build
    // ex. navigation

    return BlocListener<AuthBloc, AuthState>(
      listener: (ctx, state) {
        state.map(
          initial: (_) {},
          processing: (_) => const Center(child: CircularProgressIndicator()),
          authenticated: (_) {
            // ignore:avoid_print
            print('I am authenticated');
            /*Navigator.of(context).pushReplacementNamed();*/
          },
          unauthenticated: (_) => context.replaceRoute(const SignInPageRoute()),
        );
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
