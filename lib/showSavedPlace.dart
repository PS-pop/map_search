import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_search/location_service.dart';

class showSavedPlace extends StatefulWidget {
  final Marker marker;
  final String strPlace;

  showSavedPlace({Key? key, required this.marker, required this.strPlace}) : super(key: key);

  @override
  State<showSavedPlace> createState() => MapSampleState();
}
class MapSampleState extends State<showSavedPlace> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final Marker marker = widget.marker;
    final String strPlace = widget.strPlace;

    return Scaffold(
      appBar: AppBar(title: Text(widget.strPlace),),
      body: GoogleMap(
        // myLocationEnabled: true,
        mapType: MapType.normal,
        markers: {marker},
        initialCameraPosition: CameraPosition(
            target: marker.position,
            zoom: 15
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          },
      ),
    );
  }
}
