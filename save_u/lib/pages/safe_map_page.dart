import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:save_u/constants.dart';
import 'package:http/http.dart' as http;

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
    //_setInitialPosition();
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

  /*_setInitialPosition() async {
    position = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.lowest);
    setState(() {});
  }*/

  CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.589667551557, 127.019849627),
    zoom: 20,
  );

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller); //_controller를 이제 사용할 수 있다.
  }

  void _changeMarkers() {
    setState(() {
      _markers = _markers1;
    });
  }

  void _searchPlaces(
    String locationName,
    double latitude,
    double longitude,
  ) async {
    setState(() {
      _markers.clear();
    });
/*
    final url = Uri.parse(
        "$baseUrl?key=$API_KEY&location=$latitude,$longitude&radius=1000&language=ko&keyword=$locationName");

    final response = await http.get(url);
    print(response);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        GoogleMapController controller =
            await _controller.future; // GoogleMap Controller를 쓸 수 있게
        controller.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(latitude, longitude),
          ),
        );
        setState(
          () {
            final foundPlaces = data['results'];

            for (int i = 0; i < foundPlaces; i++) {
              _markers.add(Marker(
                markerId: MarkerId(foundPlaces[i]['place_id']),
                position: LatLng(
                  foundPlaces[i]['geometry']['location']['lat'],
                  foundPlaces[i]['geometry']['location']['lng'],
                ),
                infoWindow: InfoWindow(
                  title: foundPlaces[i]['name'],
                  snippet: foundPlaces[i]['vicinity'],
                ),
              ));
            }
          },
        );
      }
    } else {
      print("Fail to fetch place data");
    }*/
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
                    onPressed: () {
                      _searchPlaces("police", 37.589667551557, 127.019849627);
                    },
                    label: Text("경찰서"),
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
