import 'package:codedecoders/SubmissionPage.dart';
import 'package:codedecoders/screens/explore.dart';
import 'package:codedecoders/screens/heart.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
  HomePage({Key key, this.uid}) : super(key: key);
  final String uid;
  @override
  _HomePageState createState() => _HomePageState();
}
//TODO Important Line of Code for implementation of API interface
//double f = await fetchAPIResult(age.toString(), terminality.toString(), );


Future<double> fetchAPIResult(int age, int terminality, int income, int funds, int success, int cost) async {

  var uri =  new Uri.https("climatechangecentral.appspot.com", "get_ranks",{"age":age.toString(),"terminality": terminality.toString(), "income": income.toString(), "funds": funds.toString(), "success": success.toString(), "cost": cost.toString() });
  var response = await http.get(
    uri,
  );
  final responseJson = json.decode(response.body);
  print(responseJson['score']);

  return responseJson['score'];
}

class APIResult {

  final double result;

  APIResult({this.result});

  factory APIResult.fromJson(Map<String, dynamic> json) {
    return APIResult(
      result: json['score'],
    );
  }

  double getResult(){
    return result;
  }

  @override
  String toString() {
    // TODO: implement toString
    return result.toString();
  }
}

class _HomePageState extends State<HomePage> {


  int _currentIndex = 0;

  void onTabTapped(int index){
    setState(() {
     _currentIndex = index; 
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    //fetchAPIResult(10, 10, 10, 10, 10, 10);
    print("UID HOME: " + widget.uid.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        elevation: 0,
        iconSize: 32,

        items: [
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.heart_o),
            title: Text("Heart"),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.search),
            title: Text("Search"),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.database),
            title: Text("Apply for Aid"),
          ),
        ],
      ),
      body: _currentIndex == 0 ? Heart(uid: widget.uid) : _currentIndex == 1 ? Explore(uid: widget.uid) : SubmissionPage(uid: widget.uid)

    );
  }

}