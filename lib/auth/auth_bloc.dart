import 'dart:async';

import 'package:catalog/core/bloc_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc implements BlocBase {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<FirebaseUser> get authState => _auth.onAuthStateChanged;

  Future<FirebaseUser> signIn(email, password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<FirebaseUser> create(email, password) {
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  void dispose() {

  }

}
