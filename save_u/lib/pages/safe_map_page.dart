import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SafeMapPage extends StatefulWidget {
  const SafeMapPage({super.key});

  @override
  State<SafeMapPage> createState() => _SafeMapPageState();
}

class _SafeMapPageState extends State<SafeMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  //Completer() => Future<> 반환

  Set<Marker> _markers = Set();
  Set<Marker> _markers1 = Set(); //지진 해일 대피소
  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
      markerId: MarkerId('myInitialPosition'),
      position: LatLng(37.589667551557, 127.019849627),
      infoWindow: InfoWindow(title: 'My Position', snippet: 'where am I?'),
    ));
    _markers1.add(Marker(
      markerId: MarkerId('Korea Univ.'),
      position: LatLng(37.588556165888, 127.01998189277),
      infoWindow: InfoWindow(title: 'Korea Univ.', snippet: '고려대'),
    ));
  }

  CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.589667551557, 127.019849627),
    zoom: 14,
  );

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller); //_controller를 이제 사용할 수 있다.
  }

  void _changeMarkers() {
    setState(() {
      _markers = _markers1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: _markers,
          ),
          Container(
              margin: EdgeInsets.only(top: 7, right: 7, left: 7),
              alignment: Alignment.topRight,
              child: Row(
                children: <Widget>[
                  FloatingActionButton.extended(
                    onPressed: _changeMarkers,
                    label: Text("지진해일대피장소"),
                    icon: Icon(Icons.map),
                    elevation: 8,
                    backgroundColor: Colors.blue[400],
                  ),
                  SizedBox(width: 5),
                  FloatingActionButton.extended(
                    onPressed: _changeMarkers,
                    label: Text("AED"),
                    icon: Icon(Icons.map),
                    elevation: 8,
                    backgroundColor: Colors.green[400],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
