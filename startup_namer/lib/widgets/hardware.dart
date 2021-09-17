import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class Hardware extends StatefulWidget {
  const Hardware({Key? key}) : super(key: key);

  @override
  _HardwareStateState createState() => _HardwareStateState();
}

class _HardwareStateState extends State<Hardware> {
  Position? _currentPosition;

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          ListTile(
            title: const Text('Position'),
            subtitle: Column(
              children: [
                Text("Latitude: ${_currentPosition?.latitude}"),
                Text("Longitude: ${_currentPosition?.longitude}")
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            onTap: () => _getCurrentLocation(),
          ),
          ListTile(
            title: const Text('OS Version'),
            subtitle: Column(
              children: [
                Text("OS: ${Platform.operatingSystem}"),
                Text("OS Version: ${Platform.operatingSystemVersion}"),
                Text("Hostname: ${Platform.localHostname}"),
                Text("Locale: ${Platform.localeName}"),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            )
          )
        ],
        padding: const EdgeInsets.all(16),
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: Center(
  //           child: Column(
  //             children: [
  //               Text("LAT: ${_currentPosition?.latitude}, LNG: ${_currentPosition?.longitude}"),
  //               TextButton(
  //                 child: const Text('Get Position'),
  //                 onPressed: () {
  //                   _getCurrentLocation();
  //                 },
  //               ),
  //             ],
  //             mainAxisAlignment: MainAxisAlignment.center,
  //           )
  //       )
  //   );
  // }
  _getCurrentLocation() {
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
          setState(() {
            _currentPosition = position;
          });
    }).catchError((e) {
      print(e);
    });
  }
}
