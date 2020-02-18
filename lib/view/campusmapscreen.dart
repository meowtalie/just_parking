import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:just_parking/controller/campusmapscreen_controller.dart';
import 'package:just_parking/model/user.dart';

class CampusMapPage extends StatefulWidget{

  final User user;
  CampusMapPage(this.user);
  @override
  State<StatefulWidget> createState() {
    return CampusMapPageState();
  }

}

class CampusMapPageState extends State<CampusMapPage>{
  User user;
  CampusMapPageController controller;

  CampusMapPageState(){
    controller = CampusMapPageController(this);
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.blue),
        title: Text('Campus Map', style: TextStyle(color: Colors.blue)),
        ),
        body: Form(
          child: ListView(
            children: <Widget>[
              Container(
              
              child: CachedNetworkImage(
                imageUrl: 'https://pbs.twimg.com/media/EC5kcMiWwAAJx3T.jpg',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                              Icon(Icons.error_outline, size: 250),
                              height: 500,
                              width: 500,
              ),
              
              ),
            ],
          ),
        ),
      );
  }
}
