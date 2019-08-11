
import 'package:flutter/material.dart';

import '../bloc_provider.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of(context);
//    assert(_authBloc != null);

    return LoginForm(_authBloc);
  }
}
