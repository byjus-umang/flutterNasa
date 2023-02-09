// ignore: file_names
import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final error;
  final String title;
  const Error({Key? key, this.error, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 32.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.error,
            color: Colors.black,
            size: 72,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              padding: const EdgeInsets.all(3),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Text(
            error.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    ));
  }
}
