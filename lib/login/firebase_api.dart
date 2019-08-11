import 'package:catalog/login/user_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import 'model/user.dart';

class FirebaseApi implements UserApi {

  static final _auth = FirebaseAuth.instance;
  static final _store = Firestore.instance;

  @override
  Future<User> loginUser({
    @required String email,
    @required String password})
  {
    return _auth.signInWithEmailAndPassword(email: email, password: password)
        .then((firebaseUser)
    {
      // Firebase User is logged in. Get the User
      _store.collection("users")
          .document(firebaseUser.uid)
          .get()
          .then((user)
      {
        // Found the data. Build the User
        final data = user.data;
        return User(
            data["uid"],
            data["email"],
            data["username"]);
      });
    });
  }

  @override
  Future<User> createUser({
    @required String email,
    @required String password,
    @required String username})
  {
    return _auth.createUserWithEmailAndPassword(email: email, password: password)
        .then((firebaseUser)
    {
      // Firebase User was created. Create the user object in Firebase to match
      _store.collection("users")
          .document(firebaseUser.uid)
          .setData(
          {
            "uid": firebaseUser.uid,
            "email": email,
            "username": username
          });

      return firebaseUser;
    })
        .then((firebaseUser)
    {
      // We did it! Return a User
      print("User created: ${firebaseUser.uid}");
      return User(
          firebaseUser.uid,
          firebaseUser.email,
          username);
    });
  }

}