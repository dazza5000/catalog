import 'package:catalog/bloc_provider.dart';
import 'package:catalog/catalog/catalog_screen.dart';
import 'package:catalog/login/auth_bloc.dart';
import 'package:catalog/login/firebase_api.dart';
import 'package:catalog/login/login_page.dart';
import 'package:catalog/splash/splash_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final AuthBloc _authBloc = BlocProvider.of(context);
    assert(_authBloc != null);

    return StreamBuilder<FirebaseUser>(
        stream: _authBloc.authState,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashWidget();
          } else {
            return snapshot.hasData
                ? CatalogPage()
                : BlocProvider<AuthBloc>(
              bloc: AuthBloc(FirebaseApi()),
              child: LoginPage(),
            );
          }
        });
  }
}