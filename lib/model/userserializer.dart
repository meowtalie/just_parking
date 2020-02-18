import 'package:just_parking/model/serializable.dart';
import 'package:just_parking/model/serializer.dart';
import 'package:just_parking/model/user.dart';

class UserSerializer implements Serializer {
  User user;

  UserSerializer(this.user);

  @override
  Serializable deserialize(doc) {
    User user = User();
    user.setEmail(doc['email']);
    user.setUID(doc['uid']);

    return user;
  }

  @override
  Map<String, dynamic> serialize() {
    return {
      'uid': user.getUID(),
      'email': user.getEmail(),
    };
  }
}
