// This class will contain the definitionsof Routes in our app

import 'package:auto_route/auto_route.dart';
import 'package:ddd_architecture_flutter/presentation/sign_in/sign_in_page.dart';
import 'package:ddd_architecture_flutter/presentation/splash/splash_page.dart';

@MaterialAutoRouter(routes: [
  AutoRoute(page: SplashPage, initial: true),
  AutoRoute(page: SignInPage),
])
class $Router {
  SignInPage? signInPage;
  SplashPage? splashPage;
}
