import 'package:ddd_architecture_flutter/application/auth/auth/bloc/auth_bloc.dart';
import 'package:ddd_architecture_flutter/presentation/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

import '../sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
        )
      ],
      child: MaterialApp(
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
          builder: ExtendedNavigator(router: Router())),
    );
    ;
  }
}
