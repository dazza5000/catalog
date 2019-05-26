import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new _LoginForm();
  }
}

class _LoginForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<_LoginForm> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    _signIn();
                  }
                },
                child: Icon(Icons.check),
              ),
            ],
          ),
        ));
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {
    final Future<FirebaseUser> user =
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
    );

    user.then((user) {
      //todo
    }).catchError((onError) {
      //todo
    });
  }
}
