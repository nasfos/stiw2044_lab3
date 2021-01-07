import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 3: Google Map',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Select Address'),
        ),
        body: Center(
          child: Maps(),
        ),
      ),
    );
  }
}

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  double screenHeight = 0.00, screenWidth = 0.00;
  String gmaploc = "";
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(6.4676929, 100.5067673);
  MarkerId markerId1 = MarkerId("marker");
  Set<Marker> _markers = Set();
  LatLng _lastMapPosition = _center;
  Position _currentPosition;
  String _homeloc = "searching...";
  double latitude, longitude, restlat, restlon;
  GoogleMapController gmcontroller;
  CameraPosition _home;
  CameraPosition _userpos;

  // void _onCameraMove(CameraPosition position) {
  //   _lastMapPosition = position.target;
  // }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.add(Marker(
        markerId: markerId1,
        position: _center,
        draggable: true,
        onTap: () {
          print('marker tapped');
          // _loadLoc(newLatLng, newSetState);
          // _getLocationfromlatlng(lat, lng, newSetState)
        }));
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return StatefulBuilder(
      builder: (context, newSetState) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 2 * (MediaQuery.of(context).size.height / 3),
                width: MediaQuery.of(context).size.width - 10,
                child: GoogleMap(
                  markers: _markers.toSet(),
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  
                  // onCameraMove: _onCameraMove,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 17.0,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Card(
                // padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 5.2,
                  width: MediaQuery.of(context).size.width - 10,
                  child: Text('Address',
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // _getLocationfromlatlng(double lat, double lng, newSetState) async {
  //   final Geolocator geolocator = Geolocator()
  //     ..placemarkFromCoordinates(lat, lng);
  //   _currentPosition = await geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   //debugPrint('location: ${_currentPosition.latitude}');
  //   final coordinates = new Coordinates(lat, lng);
  //   var addresses =
  //       await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   var first = addresses.first;
  //   newSetState(() {
  //     _homeloc = first.addressLine;
  //     if (_homeloc != null) {
  //       latitude = lat;
  //       longitude = lng;
  //       return;
  //     }
  //   });
  //   setState(() {
  //     _homeloc = first.addressLine;
  //     if (_homeloc != null) {
  //       latitude = lat;
  //       longitude = lng;
  //       return;
  //     }
  //   });
  // }

  //  void _loadLoc(LatLng loc, newSetState) async {
  //   newSetState(() {
  //     print("insetstate");
  //     _markers.clear();
  //     latitude = loc.latitude;
  //     longitude = loc.longitude;
  //     _getLocationfromlatlng(latitude, longitude, newSetState);
  //     _home = CameraPosition(
  //       target: loc,
  //       zoom: 16,
  //     );
  //     _markers.add(Marker(
  //       markerId: markerId1,
  //       position: LatLng(latitude, longitude),
  //       infoWindow: InfoWindow(
  //         title: 'New Location',
  //         snippet: 'New Delivery Location',
  //       ),
  //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
  //     ));
  //   });
  //   _userpos = CameraPosition(
  //     target: LatLng(latitude, longitude),
  //     zoom: 14.4746,
  //   );
  //   _newhomeLocation();
  // }

  // Future<void> _newhomeLocation() async {
  //   gmcontroller = await _controller.future;
  //   gmcontroller.animateCamera(CameraUpdate.newCameraPosition(_home));
  // }
}
