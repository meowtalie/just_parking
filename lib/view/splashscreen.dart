import 'package:flutter/material.dart';
import 'package:just_parking/view/loginscreen.dart';
import 'package:just_parking/view/signupscreen.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Just Parking",
          style: TextStyle(color: Colors.blue),
        )),
      ),
      body:/*GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(35,98)),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
      ) */Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 75),
                child: Text(
                  "Welcome!",
                  style: TextStyle(fontSize: 75, color: Colors.blue),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        color: Colors.blue,
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()));
                        },
                        color: Colors.blue,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                  
                  ],
                ),
              ),
               
            ],
          ),
        ),
      ),
    );
  }
}
