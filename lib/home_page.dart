import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List cryptos;
  HomePage(this.cryptos);
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

  get children => null;

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
        child: new Column(
       children: <Widget>[new Flexible(
        child: new ListView.builder(
          itemCount: widget.cryptos.length,
          itemBuilder: (BuildContext context, int index) {
            final Map crypto = widget.cryptos[index];
            final MaterialColor color = _colors[index % _colors.length];
            return _getListUI(crypto, color);
          },
        ),
      ),],
    ));
  }

  ListTile _getListUI(Map crypto, MaterialColor color) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(crypto['name'][0]),
      ),
      title: new Text(
        crypto['name'],
        style: new TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: _getSubtitle(crypto['price_usd'], crypto['percent_change_1h']),
      isThreeLine: true,
    );
  }

  Widget _getSubtitle(String priceInUSD, String precentageVariable) {
    TextSpan priceTextWidget = new TextSpan(
        text: "\$$priceInUSD\n", style: new TextStyle(color: Colors.black));
    String precentageVariableText = "1 Hour: $precentageVariable%";
    TextSpan precentageVariableTextWidget;

    if (double.parse(precentageVariable) > 0) {
      precentageVariableTextWidget = new TextSpan(
          text: precentageVariableText,
          style: new TextStyle(color: Colors.green));
    } else {
      precentageVariableTextWidget = new TextSpan(
          text: precentageVariableText,
          style: new TextStyle(color: Colors.red));
    }

    return new RichText(
      text: new TextSpan(
          children: [priceTextWidget, precentageVariableTextWidget]),
    );
  }
}
