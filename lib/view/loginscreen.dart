import 'package:flutter/material.dart';
import 'package:just_parking/controller/loginscreen_controller.dart';
import 'package:just_parking/controller/validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  LoginScreenController _controller;

  String email;
  String password;
  var formKey = GlobalKey<FormState>();

  LoginScreenState() {
    _controller = LoginScreenController(this);
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
              "Login",
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
                RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _controller.login)
              ],
            ),
          ),
        ));
  }
}
