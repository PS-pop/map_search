import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_search/location_service.dart';
import 'package:map_search/savedPlace.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}
class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _searchController = TextEditingController();
  static final CameraPosition _kinit = CameraPosition(
    target: LatLng(13.7563, 100.5018),
    zoom: 14.4746,
  );

  Set<Marker> _markers = Set<Marker>();

  Map<int, Marker> markers = <int, Marker>{};
  var markerid = 0;
  List<String> strPlace = <String>[];
  String temp = 'Bangkok';

  @override
  void initState(){
    super.initState();
    _setMarker(LatLng(13.7563, 100.5018));
  }

  void _setMarker(LatLng point){
    // print(markerid.toString());
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId(markerid.toString()),
            position: point,
            infoWindow: InfoWindow(
                title: temp,
                snippet: 'Latitude: '+point.latitude.toString()+' Longtitude: '+point.longitude.toString()
            ),
        ),
      );
    });

    markers.addAll({markerid:_markers.elementAt(markerid)});
    print(markers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google map'),),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: TextFormField(
                controller: _searchController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(hintText: 'Search by City'),
                // onChanged: (value){
                //   print(value);
                // },
              ),
              ),
              IconButton(
                  onPressed: () async {
                    temp = _searchController.text;
                    var place = await LocationService().getPlace(temp);
                    _goToPlace(place);
                  },
                  icon: Icon(Icons.search)
              )
            ],
          ),
          Expanded(
            child: GoogleMap(
              myLocationEnabled: true,
              mapType: MapType.normal,
              markers: _markers,
              initialCameraPosition: _kinit,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 100.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            strPlace.add(temp);
            print(strPlace);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => savedPlace(markers: markers, strPlace: strPlace,),
              ),
            );
            markerid++;
          },
          label: Text('Save location'),
          icon: Icon(Icons.pin_drop_rounded),
        ),
      ),
    );
  }

  Future<void> _goToPlace(Map<String,dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat,lng),zoom: 12),
    ),
    );
    _setMarker(LatLng(lat, lng));
  }
}
