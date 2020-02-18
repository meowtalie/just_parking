import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_parking/controller/homescreen_controller.dart';
import 'package:just_parking/controller/logic_manager.dart';
import 'package:just_parking/model/appdialog.dart';
import 'package:just_parking/model/parkingspot.dart';


class HomeScreen extends StatefulWidget {
  final LogicManager manager;

  HomeScreen(this.manager);
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState(manager);
  }
}

class HomeScreenState extends State<HomeScreen> {
  HomeScreenController _controller;
  GoogleMapController mapController;
  TextFormField _searchField;
  String _searchText;
  var formKey = GlobalKey<FormState>();
  CameraPosition cameraPosition;
  bool foundData = false;

  HomeScreenState(manager) {
    _controller = HomeScreenController(this, manager);
    _searchField = TextFormField(
      decoration: InputDecoration(hintText: "Search for Parking Lot"),
      onSaved: (value) {
        if (!value.contains('lot')) {
          String x = "lot ";
          x += value;
          _searchText = x;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Just Parking"),
          actions: <Widget>[
            FlatButton(
              child: Text("logout"),
              onPressed: _controller.logout,
            )
          ],
        ),
         drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.map, color: Colors.blue),
                title: Text('Campus Map', style: TextStyle(color: Colors.blue)),
                onTap: _controller.campusMapPage,
              ),
            ],
          ),
        ),


        body: Column(
          children: <Widget>[
            Container(
                child: Form(
              key: formKey,
              child: Row(
                children: <Widget>[
                  Expanded(child: _searchField),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    onPressed: () async {
                      formKey.currentState.save();
                      setState(() {
                        foundData = true;
                      });
                    },
                  )
                ],
              ),
            )),
            Container(
              child: Expanded(
                child: Visibility(
                  visible: foundData,
                  child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('parkingSpots')
                        .where('lot', isEqualTo: _searchText)
                        /*.where(
                          'status',
                          isEqualTo: ParkingSpot.AVAILABLE,
                        )*/
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData == false)
                        return LinearProgressIndicator();
                      if (snapshot.data.documents.length == 0)
                        return Center(
                          child: Text(
                              'no available parking spots in $_searchText',
                              softWrap: true,
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 30)),
                        );
                      else
                        return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            Color color;
                            if (snapshot.data.documents[index]['status'] ==
                                ParkingSpot.UNAVAILABLE) color = Colors.red;
                            if (snapshot.data.documents[index]['status'] ==
                                ParkingSpot.AVAILABLE) color = Colors.green;
                            if (snapshot.data.documents[index]['status'] ==
                                ParkingSpot.HOLD) color = Colors.amber;

                            return ListTile(
                              //enabled: color == Colors.green,
                              leading: Icon(
                                Icons.accessible,
                                color: color,
                              ),
                              title: Text(
                                "spot # ${snapshot.data.documents[index]['spotNumber']}",
                                style: TextStyle(color: color),
                              ),
                              onTap: color != Colors.green
                                  ? () {
                                      AppDialog.showErrorDialog(context,
                                          "this spot is held or reserved by another user");
                                    }
                                  : () async {
                                      _controller.reserveSpot(
                                          snapshot, index, context);
                                    },
                            );
                          },
                        );
                    },
                  ),
                ),
              ),
            )
            /*Container(
              child: Expanded(
                child: GoogleMap(
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                      target: _controller.getUserLocation(), zoom: 20),
                  scrollGesturesEnabled: true,
                  rotateGesturesEnabled: true,
                  mapType: MapType.hybrid,
                  zoomGesturesEnabled: true,
                  mapToolbarEnabled: true,
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                ),
              ),
            )*/
          ],
        ));
  }
}
