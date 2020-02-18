import 'package:just_parking/model/user.dart';
import 'package:just_parking/model/userserializer.dart';

class UserManager {
  User _user;
  UserSerializer _serializer;

  UserManager() {
    _user = User();
    _serializer = UserSerializer(_user);
  }

  void setUserInfo(String email, String password) {
    _user.setEmail(email);
    _user.setPassword(password);
  }

  void setUserUID(String uid) {
    _user.setUID(uid);
  }

  String getUserUID() {
    return _user.getUID();
  }

  User getUser() {
    return _user;
  }

  Map<String, dynamic> serializeUserInfo() {
    return _serializer.serialize();
  }

  User deserializeUserInfo(var doc) {
    return _serializer.deserialize(doc);
  }
}
