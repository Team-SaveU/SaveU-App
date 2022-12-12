import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  Set<Marker> _markers_earthquake = Set();
  Set<Marker> _markers_AED = Set();
  Set<Marker> _markers_hospital = Set();
  @override
  void initState() {
    super.initState();

    //성북구 지진옥외대피장소
    _markers_earthquake.add(Marker(
      markerId: MarkerId('earthquake1'),
      position: LatLng(37.59744596159632, 127.0251980497349),
      infoWindow: InfoWindow(title: '개운산 공원'),
    ));

    _markers_earthquake.add(Marker(
      markerId: MarkerId('earthquake2'),
      position: LatLng(37.59564608261264, 127.01176220374178),
      infoWindow: InfoWindow(title: '우촌초등학교 운동장'),
    ));

    _markers_earthquake.add(Marker(
      markerId: MarkerId('earthquake3'),
      position: LatLng(37.59418475797521, 127.0233229605466),
      infoWindow: InfoWindow(title: '성신여자중학교 운동장'),
    ));

    _markers_earthquake.add(Marker(
      markerId: MarkerId('earthquake4'),
      position: LatLng(37.59791548559432, 127.01992133364298),
      infoWindow: InfoWindow(title: '고명중학교 운동장'),
    ));

    _markers_earthquake.add(Marker(
      markerId: MarkerId('earthquake5'),
      position: LatLng(37.6018151620627, 127.02788905780827),
      infoWindow: InfoWindow(title: '개운초등학교 운동장'),
    ));

    _markers_earthquake.add(Marker(
      markerId: MarkerId('earthquake6'),
      position: LatLng(37.59492326387658, 127.02482919145105),
      infoWindow: InfoWindow(title: '개운중학교 운동장'),
    ));

    //성북구 AED 위치
    _markers_AED.add(Marker(
      markerId: MarkerId('AED1'),
      position: LatLng(37.599144919576, 127.01373838345),
      infoWindow: InfoWindow(title: '돈암코오롱하늘채아파트(관리동 입구)'),
    ));

    _markers_AED.add(Marker(
      markerId: MarkerId('AED2'),
      position: LatLng(37.595893281731, 127.00866801673),
      infoWindow:
          InfoWindow(title: '성북구민헬스센터 (지하1층 헬스장)', snippet: '성북구민회관 지하1층'),
    ));

    _markers_AED.add(Marker(
      markerId: MarkerId('AED3'),
      position: LatLng(37.590497458678, 127.02215700068),
      infoWindow: InfoWindow(title: '성신여자대학교 (성신건강관리센터 입구)'),
    ));
    _markers_AED.add(Marker(
      markerId: MarkerId('AED4'),
      position: LatLng(37.591181, 127.022866),
      infoWindow: InfoWindow(title: '성신여자대학교 (수정관 로비)'),
    ));
    _markers_AED.add(Marker(
      markerId: MarkerId('AED5'),
      position: LatLng(37.591839, 127.021731),
      infoWindow: InfoWindow(title: '성신여자대학교 (체육관)'),
    ));
    _markers_AED.add(Marker(
      markerId: MarkerId('AED6'),
      position: LatLng(37.595151958021, 127.02316933079),
      infoWindow: InfoWindow(title: '성신여자중학교 (4층 복도)'),
    ));
    _markers_AED.add(Marker(
      markerId: MarkerId('AED7'),
      position: LatLng(37.591091734683, 127.00704666517),
      infoWindow: InfoWindow(title: '해오름스포츠센터 (1층 출입구 우측)', snippet: '한신한진아파트'),
    ));
    _markers_AED.add(Marker(
      markerId: MarkerId('AED8'),
      position: LatLng(37.597487327483, 127.01245719545),
      infoWindow: InfoWindow(title: '동소문현대아파트 (정문경비실)'),
    ));
    _markers_AED.add(Marker(
      markerId: MarkerId('AED9'),
      position: LatLng(37.594293317429, 127.02492985037),
      infoWindow: InfoWindow(title: '개운중학교 (본관3층교무실옆)'),
    ));
    _markers_AED.add(Marker(
      markerId: MarkerId('AED10'),
      position: LatLng(37.599798492761, 127.01376011727),
      infoWindow: InfoWindow(title: '아리랑시네센터 (1층 정문 내 2관 상영관 앞)'),
    ));
    _markers_AED.add(Marker(
      markerId: MarkerId('AED11'),
      position: LatLng(37.597275036253, 127.01237510243),
      infoWindow: InfoWindow(title: '경찰(돈암지구대) (소내책상컴퓨터옆)'),
    ));
    _markers_AED.add(Marker(
      markerId: MarkerId('AED12'),
      position: LatLng(37.597275036253, 127.01237510243),
      infoWindow: InfoWindow(title: '돈암치안센터 (순찰차11호 998무)'),
    ));

    _markers_AED.add(Marker(
      markerId: MarkerId('AED13'),
      position: LatLng(37.595151958021, 127.02316933079),
      infoWindow: InfoWindow(title: '성신초등학교 (본관2층 통로벽)'),
    ));

    _markers_AED.add(Marker(
      markerId: MarkerId('AED14'),
      position: LatLng(37.594487663036, 127.02246669525),
      infoWindow: InfoWindow(title: '성신여자고등학교 (본관 1층 교무실 앞)'),
    ));

    //성북구 응급실
    _markers_hospital.add(Marker(
      markerId: MarkerId('hospital1'),
      position: LatLng(37.596838, 127.035598),
      infoWindow: InfoWindow(title: '성북 우리 아이들 병원'),
    ));
    _markers_hospital.add(Marker(
      markerId: MarkerId('hospital2'),
      position: LatLng(37.586497162966, 127.02745249685),
      infoWindow: InfoWindow(title: '고려대 부속 안암 병원'),
    ));
    _markers_hospital.add(Marker(
      markerId: MarkerId('hospital3'),
      position: LatLng(37.5892371, 127.0073736),
      infoWindow: InfoWindow(title: '리누스 병원'),
    ));

    _markers_hospital.add(Marker(
      markerId: MarkerId('hospital4'),
      position: LatLng(37.596747485193, 127.03560357939),
      infoWindow: InfoWindow(title: '성북 중앙 병원'),
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
    zoom: 15,
  );

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller); //_controller를 이제 사용할 수 있다.
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
                    onPressed: () {
                      setState(() {
                        _markers = _markers_earthquake;
                      });
                    },
                    label: Text("지진옥외대피장소"),
                    icon: Icon(Icons.map),
                    elevation: 8,
                    backgroundColor: Colors.blue[400],
                  ),
                  SizedBox(width: 3),
                  FloatingActionButton.extended(
                    onPressed: () {
                      setState(() {
                        _markers = _markers_AED;
                      });
                    },
                    label: Text("AED"),
                    icon: Icon(Icons.map),
                    elevation: 8,
                    backgroundColor: Colors.green[400],
                  ),
                  SizedBox(width: 3),
                  FloatingActionButton.extended(
                    onPressed: () {
                      setState(() {
                        _markers = _markers_hospital;
                      });
                    },
                    label: Text("응급실"),
                    icon: Icon(Icons.map),
                    elevation: 8,
                    backgroundColor: Colors.red[400],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
