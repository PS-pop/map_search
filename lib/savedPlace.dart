import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_search/showSavedPlace.dart';

class savedPlace extends StatelessWidget {

  final Map<int, Marker> markers;
  final List<String> strPlace;

  savedPlace({Key? key, required this.markers, required this.strPlace}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Place'),
      ),
      body: ListView.builder(
        itemCount: markers.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.place),
            title: Text('Loc id '+index.toString()+' '+strPlace[index]),
            subtitle: Text('Latitude: '+markers[index]!.position.latitude.toString()+' Longtitude: '+markers[index]!.position.longitude.toString()),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => showSavedPlace(marker: markers[index]!, strPlace: strPlace[index],)),);
              // Navigate to second route when tapped.
            },
          );
        },
      ),
    );
  }
}
