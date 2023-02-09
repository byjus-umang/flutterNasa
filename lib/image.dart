import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final String image;
  const MyWidget({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Image you are looking for"),
            backgroundColor: Colors.redAccent),
        body: Center(
            child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Image.network(image),
        )));
  }
}
