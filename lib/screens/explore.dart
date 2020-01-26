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
                    title: Text("Heart Diseases",
                        style: TextStyle(
                            fontFamily: "CentraleSansRegular",
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text("the leading cause of death for both men and women each year, heart disease claims the most lives nationally and internationally.",
                        style: TextStyle(
                          fontFamily: "CentraleSansRegular",
                          fontSize: 15,
                        )),
                  ),
                  ListTile(
                    trailing: Icon(Icons.more_vert),
                    leading: Image.asset("assets/ad2.png"),
                    title: Text("Sickle Cell Anemia",
                        style: TextStyle(
                            fontFamily: "CentraleSansRegular",
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text("an inherited blood disorder affecting more than 200,000 Americans, causes a lifetime of pain for the afflicted patient.",
                        style: TextStyle(
                          fontFamily: "CentraleSansRegular",
                          fontSize: 15,
                        )),
                  ),
                  ListTile(
                    trailing: Icon(Icons.more_vert),
                    leading: Image.asset("assets/ad3.png"),
                    title: Text("Parkinson’s",
                        style: TextStyle(
                            fontFamily: "CentraleSansRegular",
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text("How does it feel to experience constant shaking with slow limb movement and impaired posture?",
                        style: TextStyle(
                          fontFamily: "CentraleSansRegular",
                          fontSize: 15,
                        )),
                  ),
                  ListTile(
                    trailing: Icon(Icons.more_vert),
                    leading: Image.asset("assets/ad3.png"),
                    title: Text("Diabetes",
                        style: TextStyle(
                            fontFamily: "CentraleSansRegular",
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text("29.1 million people in the United States have diabetes, but 8.1 million may be undiagnosed and unaware of their condition.",
                        style: TextStyle(
                          fontFamily: "CentraleSansRegular",
                          fontSize: 15,
                        )),
                  ),
                  ListTile(
                    trailing: Icon(Icons.more_vert),
                    leading: Image.asset("assets/ad3.png"),
                    title: Text("ALS",
                        style: TextStyle(
                            fontFamily: "CentraleSansRegular",
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text("Imagine experiencing weakening muscles and slower cognitive functioning to the extent where you are completely paralyzed. ",
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
