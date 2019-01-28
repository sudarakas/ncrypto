import 'dart:async';
import 'dart:convert/';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List cryptos;
  final List<MaterialColor> _colors = [
    Colors.lime,
    Colors.orange,
    Colors.red,
    Colors.blue
  ];

  @override
  void initState() async {
    super.initState();
    cryptos = await getCryptos();
  }

  Future<List> getCryptos() async {
    String apiUrl = "http://api.coinmarketcap.com/v1/ticker/?limit=50";
    http.Response response = await http.get(apiUrl);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("NCrypto - Find Crypto Rates"),
      ),
      body: _ncryptoWidget(),
    );
  }

  Widget _ncryptoWidget() {
    return new Container(
      child: new Flexible(
        child: new ListView.builder(
          itemCount: cryptos.length,
          itemBuilder: (BuildContext context, int index) {
            final Map crypto = cryptos[index];
            final MaterialColor color = _colors[index % _colors.length];

            return _getListUI(crypto, color);
          },
        ),
      ),
    );
  }

  ListTile _getListUI(Map crypto, MaterialColor color) {
    return new ListTile(
      leading: new CircleAvatar(backgroundColor: color,),
    );
  }
}
