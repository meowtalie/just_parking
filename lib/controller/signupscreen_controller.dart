import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_parking/controller/logic_manager.dart';
import 'package:just_parking/model/appdialog.dart';
import 'package:just_parking/view/homescreen.dart';
import 'package:just_parking/view/signupscreen.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:geolocator/geolocator.dart';

class SignupScreenController {
  SignupScreenState _state;
  LogicManager _manager;

  SignupScreenController(this._state) {
    _manager = LogicManager();
  }

  void signup() async {
    print("controller sign up called");
    if (_state.formKey.currentState.validate()) {
      _state.formKey.currentState.save();
      try {
        await _manager.signUp(_state.email, _state.password);

        
            await LocationPermissions().requestPermissions();
        Position position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        _manager
            .getUser()
            .setCurrentLocation(position.longitude, position.latitude);

        Navigator.pushReplacement(_state.context,
            MaterialPageRoute(builder: (context) => HomeScreen(_manager)));
      } catch (e) {
        print(e.toString());
        try {
          AppDialog.showErrorDialog(_state.context, e.message);
        } catch (e) {
          print(e.toString());
        }
      }
    }
  }
}
