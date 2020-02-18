import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:just_parking/controller/logic_manager.dart';
import 'package:just_parking/model/appdialog.dart';
import 'package:just_parking/view/homescreen.dart';
import 'package:just_parking/view/loginscreen.dart';

class LoginScreenController {
  LoginScreenState state;
  LogicManager _manager;

  LoginScreenController(this.state) {
    _manager = LogicManager();
  }

  void login() async {
    try {
      if (state.formKey.currentState.validate()) {
        state.formKey.currentState.save();
        await _manager.login(state.email, state.password);

       // return;
        Position position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        _manager
            .getUser()
            .setCurrentLocation(position.longitude, position.latitude);
        Navigator.pop(state.context);
        Navigator.pushReplacement(state.context,
            MaterialPageRoute(builder: (context) => HomeScreen(_manager)));
      }
    } catch (e) {
      AppDialog.showErrorDialog(state.context, e.message);
    }
  }
}
