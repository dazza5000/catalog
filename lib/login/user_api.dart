import 'package:meta/meta.dart';

import 'model/user.dart';

abstract class UserApi {

  Future<User> loginUser({@required String email, @required String password});

  Future<User> createUser({
    @required String email,
    @required String password,
    @required String username
  });
}