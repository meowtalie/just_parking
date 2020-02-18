import 'package:flutter/material.dart';
import 'package:just_parking/controller/signupscreen_controller.dart';
import 'package:just_parking/controller/validator.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignupScreenState();
  }
}

class SignupScreenState extends State<SignupScreen> {
  SignupScreenController _controller;
  String email;
  String password;
  var formKey = GlobalKey<FormState>();

  SignupScreenState() {
    _controller = SignupScreenController(this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Center(
            child: Text(
              "Sign Up",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.blue)),
                  validator: Validator.validateEmail,
                  onSaved: (value) => email = value,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.blue)),
                  validator: Validator.validatePassword,
                  onSaved: (value) => password = value,
                  obscureText: true,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(color: Colors.blue)),
                  validator: (value) {
                    formKey.currentState.save();
                    print(value);
                    print(password);

                    if (value != password || value.trim().length == 0)
                      return "Confirmation does not match password";
                    return null;
                  },
                  obscureText: true,
                ),
                RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    "Signup",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed:_controller.signup 
                  
                )
              ],
            ),
          ),
        ));
  }
}
