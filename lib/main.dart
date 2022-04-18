import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_search/location_service.dart';

import 'location_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Route Push Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const home_page(),
    );
  }
}

class home_page extends StatelessWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(image: AssetImage('assets/earth.png'),),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Center(
                      child: ElevatedButton(
                        child: const Text('Map search'),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MapSample()),);
                          // Navigate to second route when tapped.
                        },
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        child: const Text('button 2'),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const thirdRoute()),);
                          // Navigate to second route when tapped.
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Center(
                      child: ElevatedButton(
                        child: const Text('button 3'),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const fourthRoute()),);
                          // Navigate to second route when tapped.
                        },
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        child: const Text('About us'),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const aboutUs_page()),);
                          // Navigate to second route when tapped.
                        },
                      ),
                    ),
                  ],
                ),
              ]
          ),
        ],
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _searchController = TextEditingController();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(13.7563, 100.5018),
    zoom: 14.4746,
  );

  Set<Marker> _markers = Set<Marker>();

  @override
  void initState(){
    super.initState();

    _setMarker(LatLng(13.7563, 100.5018));
  }

  void _setMarker(LatLng point){
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId('marker'),
            position: point
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Google map'),),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: TextFormField(
                controller: _searchController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(hintText: 'Search by City'),
                onChanged: (value){
                  print('valure: '+value);
                },
              )),
              IconButton(
                  onPressed: () async {
                    var place = await LocationService().getPlace(_searchController.text);
                    _goToPlace(place);
                  },
                  icon: Icon(Icons.search)
              )
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: _markers,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
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

class thirdRoute extends StatelessWidget {
  const thirdRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("New data is coming soon..."),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate back to first route when tapped.
              },
              child: const Text('Go back!'),
            ),
          ),
        ],
      ),
    );
  }
}

class fourthRoute extends StatelessWidget {
  const fourthRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("New data is coming soon..."),

          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate back to first route when tapped.
              },
              child: const Text('Go back!'),
            ),
          ),
        ],
      ),
    );
  }
}

class aboutUs_page extends StatelessWidget {
  const aboutUs_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About us'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Card(
            child: Column(
              children: [
                Image(image: AssetImage('assets/yoyo.PNG'),height: 200,width: 200,),
                Text("6288108"),
                Text("MISS"),
                Text("NATTAPRAPA PINJARERN"),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                Image(image: AssetImage('assets/pop.jpg'),height: 200,width: 200,),
                Text("6288131"),
                Text("MISS"),
                Text("PATTHITA SOMBOONYINGSUK"),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate back to first route when tapped.
              },
              child: const Text('Go back!'),
            ),
          ),
          const Text("New data is coming soon..."),
        ],
      ),
    );
  }
}