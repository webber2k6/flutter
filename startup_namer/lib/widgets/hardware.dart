import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gpiod/flutter_gpiod.dart';
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
          ),
          ListTile(
            title: const Text('Chips'),
            subtitle: Row(
              children: FlutterGpiod.instance.chips.map((chip) => Text("${chip.name}|${chip.label}")).toList(),
              crossAxisAlignment: CrossAxisAlignment.start,
            )
          )
        ],
        padding: const EdgeInsets.all(16),
    );
  }

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

  // void _setChipState(state) {
  //   // Retrieve the list of GPIO chips.
  //   final chips = FlutterGpiod.instance.chips;
  //
  //   // Retrieve the line with index 24 of the first chip.
  //   // This is BCM pin 24 for the Raspberry Pi.
  //
  //   final chip = chips.singleWhere(
  //         (chip) => chip.label == 'pinctrl-bcm2711',
  //         orElse: () =>
  //             chips.singleWhere(
  //                     (chip) => chip.label == 'pinctrl-bcm2835'
  //             ),
  //   );
  //
  //   // final line2 = chip.lines[24];
  //   //
  //   // // Request BCM 24 as output.
  //   // line2.requestOutput(consumer: "flutter_gpiod test", initialValue: false);
  //   // line2.setValue(state);
  //   //
  //   // line2.release();
  // }
}
