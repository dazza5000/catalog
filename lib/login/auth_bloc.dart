import 'package:catalog/bloc_provider.dart';
import 'package:catalog/login/user_api.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'model/user.dart';

class AuthBloc implements BlocBase {

  final UserApi _userApi;

  AuthBloc(
    this._userApi
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<FirebaseUser> get authState => _auth.onAuthStateChanged;

  Future<User> login(email, password) {
    return _userApi.loginUser(email: email, password: password);
  }

  Future<User> create(String email, String password, String username) {
    return _userApi.createUser(
        email: email,
        password: password,
        username: username);
  }

  @override
  void dispose() {
    print("$this disposed");
  }

}