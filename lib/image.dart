import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gaming_app/main.dart';
import 'models.dart';

class MyWidget extends StatelessWidget {
  final String image;
  const MyWidget({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Image you are looking for"),
            backgroundColor: Colors.redAccent),
        body: Center(
            child: Container(
          padding: EdgeInsets.all(5.0),
          child: Image.network(image),
        )));
  }
}
