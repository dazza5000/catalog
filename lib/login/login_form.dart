import 'dart:async';

import 'package:flutter/material.dart';

import '../bloc_provider.dart';
import 'auth_bloc.dart';

class LoginForm extends StatefulWidget {

  final AuthBloc _authBloc;

  LoginForm(
      this._authBloc
      );

  @override
  State<StatefulWidget> createState() => _LoginFormState(_authBloc);

}

class _LoginFormState extends State<LoginForm> {

  final StreamController<bool> _newUserStream = StreamController();

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  final AuthBloc _authBloc;
  AuthBloc _authBloc2;

  _LoginFormState(
      this._authBloc
      );

  @override
  Widget build(BuildContext context) {
    _authBloc2 = BlocProvider.of(context);
//    assert(_authBloc != null);
    assert(_authBloc2 != null);

    return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: StreamBuilder<bool>(
            stream: _newUserStream.stream,
            initialData: false,
            builder: (context, snapshot) {
              return Form(
                child: buildLoginForm(snapshot.data),
                key: _formKey,
              );
            },
          ),
        )
    );
  }

  @override
  void dispose() {
    _newUserStream.close();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Widget buildLoginForm(bool isNewUser) {
    var loginForm = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'I pity the foo who doesn\'t enter an email';
                }
              }),
          TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'I pity the foo who doesn\'t enter a password';
                }
              }),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                isNewUser
                    ? _authBloc2.create(
                    _emailController.text,
                    _passwordController.text,
                    _usernameController.text)
                    .then((user) {
                  print(user.toString());
                }).catchError((error) {
                  print(error);
                })
                    : _authBloc2.login(
                    _emailController.text,
                    _passwordController.text);
              }
            },
            child: Icon(Icons.check),
          ),
          GestureDetector(
            onTap: () {
              _newUserStream.sink.add(!isNewUser);
            },
            child: isNewUser ? Text("Cancel") : Text("Create Account"),
          )
        ]
    );

    if (isNewUser) {
      loginForm.children.insert(0,
        TextFormField(
            controller: _usernameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Username'),
            validator: (String value) {
              if (value.isEmpty) {
                return 'I pity the foo who doesn\'t enter a username';
              }
            }),
      );
    }

    return loginForm;
  }
}