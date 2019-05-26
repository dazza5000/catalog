import 'package:catalog/bloc_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc implements BlocBase {

  Stream<FirebaseUser> authState = FirebaseAuth.instance.onAuthStateChanged;

  @override
  void dispose() {
    // TODO: implement dispose
  }

}