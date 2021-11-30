import 'package:ddd_architecture_flutter/application/auth/auth/bloc/auth_bloc.dart';
import 'package:ddd_architecture_flutter/presentation/injection.dart';
import 'package:ddd_architecture_flutter/presentation/route/router.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart' hide Router;

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _router = Router();

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
          )
        ],
        child: MaterialApp.router(
          routeInformationParser: _router.defaultRouteParser(),
          routerDelegate: _router.delegate(),
          title: 'Notes',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            primaryColor: Colors.green[800],
            colorScheme: ThemeData().colorScheme.copyWith(
                  secondary: Colors.blue,
                ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ));
  }
}
