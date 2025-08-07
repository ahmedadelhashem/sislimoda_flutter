// import 'dart:async';
// import 'package:sislimoda_admin_dashboard/components/alert/custom_alert_message.dart';
// import 'package:sislimoda_admin_dashboard/utility/all_app_words.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:maps_toolkit/maps_toolkit.dart' as toolkit;

// class MapHelper {
//   static bool checkIfInPolygon(
//       {required LatLng tap, required List<LatLng> vertices}) {
//     List<toolkit.LatLng> allpointsdata = [];
//     vertices.forEach((element) {
//       allpointsdata.add(toolkit.LatLng(element.latitude, element.longitude));
//     });

//     var tapTemp = toolkit.LatLng(tap.latitude, tap.longitude);
//     return toolkit.PolygonUtil.containsLocation(tapTemp, allpointsdata, true);
//   }

//   static Set<Polygon> polygon(List<String> polygonStringList) {
//     List<String> mylist = polygonStringList;

//     //polygon
//     List<LatLng> polygonCoords = [];

//     //mylist.remove(mylist[mylist.length - 1]);
//     mylist.forEach((element) {
//       var x = element.split(',');
//       if (element != "") {
//         polygonCoords.add(LatLng(double.parse(x[0]), double.parse(x[1])));
//       }
//     });

//     Set<Polygon> polygonSet = new Set();
//     polygonSet.addAll([
//       Polygon(
//           polygonId: PolygonId('myPolygon'),
//           points: polygonCoords,
//           fillColor: Colors.red.withOpacity(0.25),
//           strokeWidth: 3,
//           strokeColor: Colors.red.withOpacity(1))
//     ]);
//     return polygonSet;
//   }

//   static addMarker(
//       {required LatLng latLng,
//       required Map<MarkerId, Marker> markers,
//       required Function(Marker) afterMakerCreated}) {
//     markers = <MarkerId, Marker>{};
//     var markerIdVal = markers.length + 1;
//     final MarkerId markerId = MarkerId(markerIdVal.toString());
//     //////print(markers.length);
//     // creating a new MARKER
//     final Marker marker = Marker(
//       markerId: markerId,
//       position: LatLng(
//         latLng.latitude,
//         latLng.longitude,
//       ),
//       // infoWindow: InfoWindow(title: '', snippet: '*'),
//       onTap: () {},
//     );

//     afterMakerCreated(marker);

//     //////print(marker.position.latitude);
//     //////print(marker.position.latitude);
//     markers[markerId] = marker;
//     return markers;
//   }

//   static Future updateCameraLocation(
//       LatLng latLng, Completer<GoogleMapController> mapController) async {
//     CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: latLng,
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414,
//     );
//     final GoogleMapController controller = await mapController.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }

//   /// Determine the current position of the device.
//   ///
//   /// When the location services are not enabled or permissions
//   /// are denied the `Future` will return an error.
//   static Future<Position?> determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();

//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       await CustomAlert.showAlertMessage(
//         txt: "HourlyTR.enable_location.trans",
//         alertType: AlertType.error,
//       );
//       permission = await Geolocator.requestPermission();
//       //////print('Location services are disabled.' * 100);
//       //return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         await CustomAlert.showAlertMessage(
//           txt: " HourlyTR.enable_location.trans",
//           alertType: AlertType.error,
//         );

//         return null;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       await CustomAlert.showAlertMessage(
//         txt: " HourlyTR.enable_location.trans",
//         alertType: AlertType.error,
//       );

//       return null;

//       // return Future.error(
//       //     'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition();
//   }

//   static LatLng defaultLocation = LatLng(24.705450, 46.677245);
// }
