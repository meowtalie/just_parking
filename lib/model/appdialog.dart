
import 'package:flutter/material.dart';

class AppDialog {
  static showProgressDialog(BuildContext statecontext, String message) async {
    //Navigator.pop(statecontext);
    await showDialog(
        context: statecontext,
        builder: (context) => AlertDialog(
            title: Text("Processing"),
            content: Row(
              children: <Widget>[Text(message), CircularProgressIndicator()],
            )));
  }

  static showErrorDialog(BuildContext statecontext, String message) {
    // Navigator.pop(statecontext);
    showDialog(
        context: statecontext,
        builder: (context) => AlertDialog(
              title: Text("Error"),
              content: Column(
                children: <Widget>[Icon(Icons.error), Text(message)],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(statecontext);
                  },
                )
              ],
            ));
  }

  static showSuccessDialog(BuildContext statecontext, String message) {
    // Navigator.pop(statecontext);
    showDialog(
        context: statecontext,
        builder: (context) => AlertDialog(
              title: Text("Success"),
              content: Column(
                children: <Widget>[Icon(Icons.check), Text(message)],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(statecontext);
                  },
                )
              ],
            ));
  }

}
