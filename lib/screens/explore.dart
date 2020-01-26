import 'package:codedecoders/screens/DonationPage.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class Explore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Image(
            alignment: Alignment.topCenter,
            image: AssetImage("assets/image3.png"),
            fit: BoxFit.contain,
            width: double.infinity,
          ),
          Positioned(
            top: 40,
            left: 30,
            right: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    LineAwesomeIcons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Text(
                  "Explore",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontFamily: 'CentraleSansRegular'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Causes",
                      style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 32,
                          fontFamily: 'CentraleSansRegular',
                          fontWeight: FontWeight.w100),
                    ),
                    Text(
                      "",
                      style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 20,
                          fontFamily: 'CentraleSansRegular',
                          fontWeight: FontWeight.w100),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 130,
            ),
            height: 270,
            width: 400,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                FlatButton(
                  child: Container(
                      color: Colors.transparent,
                      child: Image.asset("assets/slide1.png")),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DonationPage(
                                cause: "Cancer",
                                why: "ah",
                              )),
                    );
                  },
                ),
                FlatButton(
                  child: Container(
                      color: Colors.transparent,
                      child: Image.asset("assets/slide2.png")),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DonationPage(
                                cause: "Dementia",
                                why: "aa",
                              )),
                    );
                  },
                ),
                FlatButton(
                  child: Container(
                      color: Colors.transparent,
                      child: Image.asset("assets/slide3.png")),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DonationPage(
                                cause: "Alzheimer's",
                                why: "bb",
                              )),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 380),
            height: 400,
            width: 400,
            child: Column(children:[
              Flexible(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    trailing: Icon(Icons.more_vert),
                    leading: Image.asset("assets/ad1.png"),
                    title: Text("Feeding America Society",
                        style: TextStyle(
                            fontFamily: "CentraleSansRegular",
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text("Oregon",
                        style: TextStyle(
                          fontFamily: "CentraleSansRegular",
                          fontSize: 15,
                        )),
                  ),
                  ListTile(
                    trailing: Icon(Icons.more_vert),
                    leading: Image.asset("assets/ad2.png"),
                    title: Text("Ubuntu",
                        style: TextStyle(
                            fontFamily: "CentraleSansRegular",
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text("Maryland",
                        style: TextStyle(
                          fontFamily: "CentraleSansRegular",
                          fontSize: 15,
                        )),
                  ),
                  ListTile(
                    trailing: Icon(Icons.more_vert),
                    leading: Image.asset("assets/ad3.png"),
                    title: Text("Dallas Morning News",
                        style: TextStyle(
                            fontFamily: "CentraleSansRegular",
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text("Washington",
                        style: TextStyle(
                          fontFamily: "CentraleSansRegular",
                          fontSize: 15,
                        )),
                  ),
                ],
              ),
            ),],),
          ),
        ],
      ),
    );
  }
}
