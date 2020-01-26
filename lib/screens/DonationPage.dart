import 'package:flutter/material.dart';

class DonationPage extends StatefulWidget {
  DonationPage({Key key, this.cause, this.why, this.can, this.did}) : super(key: key);

  String cause;
  String why;
  String can;
  String did;
  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancer'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Open Cancer Page'),
           onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>DonationPage()));
           },
        ),
      ),
    );
  }





















}