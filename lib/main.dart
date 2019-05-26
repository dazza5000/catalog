import 'package:catalog/application_bloc.dart';
import 'package:catalog/bloc_provider.dart';
import 'package:catalog/login/auth_bloc.dart';
import 'package:catalog/splash/splash_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  return runApp(
      BlocProvider<ApplicationBloc>(
        bloc: ApplicationBloc(),
        child: BlocProvider<AuthBloc>(
          bloc: AuthBloc(),
          child: MyApp(),
        ),
      )
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Welcome to Flutter',
        home: SplashPage()
    );
  }
}