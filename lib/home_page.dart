import 'package:flutter/material.dart';
import 'package:map_search/HowToUse.dart';
import 'package:map_search/MapSample.dart';

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
              child: const Text('HowToUse'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HowToUse()),);
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
          // const Text("New data is coming soon..."),
        ],
      ),
    );
  }
}
