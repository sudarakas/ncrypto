import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:n_crypto/home_page.dart';

void main() async {
  List crypots = await getCryptos();
  print(crypots);
  runApp(new MyApp(crypots));
}

class MyApp extends StatelessWidget {
  final List _crypots;
  MyApp(this._crypots);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.green),
      home: new HomePage(_crypots),
    );
  }
}

Future<List> getCryptos() async {
  String apiUrl = "http://api.coinmarketcap.com/v1/ticker/?limit=50";
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
}
