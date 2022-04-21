import 'package:flutter/material.dart';

class HowToUse extends StatelessWidget {
  const HowToUse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HowToUse'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Center(
          child: Column(
            children: [
              const Text("Search by City"),
              Text('This will allow you to search by city.'),
              Image(image: AssetImage('assets/htu1.PNG')),
            ],
          ),
        ),
      ),
    );
  }
}
