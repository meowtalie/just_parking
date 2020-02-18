import 'package:flutter/material.dart';
import 'package:just_parking/view/loginscreen.dart';

class SplashScreenController {
  

  void navToLoginPage(BuildContext screencontext)
  {
    Navigator.push(
      screencontext, MaterialPageRoute(
        builder: (context)=> LoginScreen()
      )
    );

  }

  void navToSignupPage()
  {
    
  }
}
