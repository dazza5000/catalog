import 'package:catalog/splash/splash_page.dart';
import 'package:flutter/material.dart';

import 'bloc_provider.dart';
import 'catalog/catalog_screen.dart';
import 'login/auth_bloc.dart';
import 'login/firebase_api.dart';
import 'login/user_api.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final UserApi _userApi = FirebaseApi();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: BlocProvider(
          child: SplashPage(),
          bloc: AuthBloc(_userApi)),
      routes: buildRoutes(),
    );
  }

  Map<String, WidgetBuilder> buildRoutes() {
    return {
      "/catalog": (context) => CatalogPage()
    };
  }
}