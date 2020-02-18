import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_parking/controller/authenticator.dart';
import 'package:just_parking/controller/firebase.dart';
import 'package:just_parking/controller/user_manager.dart';
import 'package:just_parking/model/user.dart';

class LogicManager {
 
  UserManager _userManager;
  Authenticator _authenticator;
  Firebase _firebase;

  LogicManager() {
    
    _authenticator = Authenticator();
    _firebase = Firebase();
    _userManager = UserManager();
  }

  User getUser() {
    return _userManager.getUser();
  }

  login(String email, String password) async {
   _userManager.setUserInfo(email, password);
      AuthResult ar = await _authenticator.login(email, password);
      if (ar.user != null)
        _userManager.getUser().setUID(ar.user.uid);
      else
        throw Exception("No User found");
  }

  signUp(String email, String password) async {
    // set email and password from text field
    _userManager.setUserInfo(email, password);

    //attempt to sign up with the user's email and password
    String uid = await _authenticator.signup(email, password);

    // if successful set the returned uid
    _userManager.getUser().setUID(uid);

//attempt to login with created user
    await login(email, password);
//create doc in user collection with user data
    await _firebase.createUserDoc(_userManager);
    print("Sign up successful");
  }

  logout() async {
    await _authenticator.logout();
  }
}
