import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaming_app/models.dart';
import 'package:intl/intl.dart';
import 'package:gaming_app/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'Error.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Date Picker",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  TextEditingController dateInput = TextEditingController();
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  late Future<Nasa> nasa;
  String uri =
      "https://api.nasa.gov/planetary/apod?api_key=OHF8WZZT5AIs0UklqfKW1mHQvs6zLputIzkinGbb";

  Future<Nasa> fetchdata() async {
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      Nasa jsonList = Nasa.fromJson(jsonDecode(response.body));

      print(jsonList);

      return jsonList;
    }
    throw Exception("Http call not made");
  }

  @override
  void initState() {
    //set the initial value of text field
    super.initState();
    nasa = fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("The Nasa Apod App"),
            backgroundColor: Colors.redAccent,
            elevation: 16.0,
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    setState(() {
                      nasa = fetchdata();
                    });
                  },
                  icon: Icon(Icons.autorenew))
            ] //background color of app bar
            ),
        body: FutureBuilder<Nasa>(
            future: nasa,
            builder: (BuildContext context, AsyncSnapshot<Nasa> snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                    child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.0),
                        width: 250,
                        child: Text(
                          snapshot.data!.title.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: double.tryParse('16'),
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(15),
                          height: MediaQuery.of(context).size.width / 3,
                          child: Center(
                              child: ElevatedButton(
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime.now());

                              if (pickedDate != null) {
                                //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);

                                //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  //set output date to TextField value.
                                  String hi =
                                      "https://api.nasa.gov/planetary/apod?api_key=OHF8WZZT5AIs0UklqfKW1mHQvs6zLputIzkinGbb&date=";
                                  date = formattedDate;
                                  uri = hi + date;

                                  nasa = fetchdata();
                                });
                              } else {}
                            },
                            child: Text("Date"),
                          )))
                    ],
                  ),
                  Center(
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        width: 350,
                        height: 350,
                        child: Image.network(
                          snapshot.data!.url.toString(),
                          width: 350,
                          height: 350,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyWidget(
                                  image: snapshot.data!.url.toString()),
                            ));
                      },
                    ),
                  ),
                  Center(
                      child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "$date",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.red,
                      ),
                    ),
                  )),
                  Center(
                    child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          snapshot.data!.explanation.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: double.tryParse('16'),
                              decoration: TextDecoration.underline),
                        )),
                  ),
                ]));
              } else if (snapshot.hasError) {
                return Text("error"); //Error(error: snapshot.error);
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ));
              }
            }));
  }
}
