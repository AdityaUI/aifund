import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:stellar/stellar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codedecoders/DonateLogic.dart';

class Heart extends StatefulWidget {
  Heart({Key key, this.uid}) : super(key: key);

  final String uid;

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  KeyPair userPair;
  AccountResponse myAccount;


  @override
  void initState() {
    super.initState();
      Firestore.instance
          .collection("users")
          .document(widget.uid)
          .get()
          .then((given) {
        setState(() {
          userPair = KeyPair.fromAccountId(given.data["Public Key"].toString());
          Server("https://horizon-testnet.stellar.org")
              .accounts
              .account(KeyPair.fromAccountId(given.data["Public Key"]))
              .then((account) {
            myAccount = account;
          });
        });
      });
  }

  Future<AccountResponse> loginStellar() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
      DocumentSnapshot firestore = await Firestore.instance
          .collection("users")
          .document(user.uid)
          .get();
        userPair = KeyPair.fromAccountId(firestore.data["Public Key"].toString());
        myAccount = await Server("https://horizon-testnet.stellar.org")
            .accounts
            .account(KeyPair.fromAccountId(firestore.data["Public Key"]));
        return myAccount;
  }

  @override
  Widget build(BuildContext context) {
    print("heart uid: " + widget.uid.toString());
    return SingleChildScrollView(
      key: new GlobalKey(),
      child: Column(children:[
        Stack(
        children: <Widget>[
          Image(
            alignment: Alignment.topCenter,
            image: AssetImage("assets/image2.png"),
            fit: BoxFit.contain,
            width: double.infinity,
          ),
          Positioned(
            top: 50,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Causes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontFamily: "CentraleSansRegular",
                    )),
                Text("Total Donations",
                    style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 32,
                        fontFamily: "CentraleSansRegular",
                        fontWeight: FontWeight.w100)),
              ],
            ),
          ),],),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                material.Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
//                    Column(
//                      children: <Widget>[
//                        Text(
//                          "\$1,080",
//                          style: TextStyle(
//                              color: Color(0xff3cabff),
//                              fontSize: 35,
//                              fontFamily: 'CentraleSansRegular',
//                              fontWeight: FontWeight.bold),
//                        ),
//                        Text(
//                          "ONE TIME",
//                          style: TextStyle(
//                            color: Colors.black,
//                            fontSize: 20,
//                            fontFamily: 'CentraleSansRegular',
//                          ),
//                        ),
//                      ],
//                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  width: 380,
                  height: 80,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF6A1B9A), Color(0xff3cabff)],
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: material.Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "THIS MONTH",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'CentraleSansRegular'),
                      ),
                      Text(
                        "\$32.20",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'CentraleSansRegular'),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: (loginStellar()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        !snapshot.hasError) {
                      print(snapshot.data);
                      return Column(
                        children: <Widget>[
                          SizedBox(height: 20,),
                          Text(
                            "\$${double.parse(snapshot.data.balances[0].balance)/1000}",
                            style: TextStyle(
                                color: Color(0xff3cabff),
                                fontSize: 20,
                                fontFamily: 'CentraleSansRegular',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "My Balance",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'CentraleSansRegular',
                            ),
                          ),
                        ],
                      );
                    }
                    else {
                      return CircularProgressIndicator();
                    }

                  },
                ),
                SizedBox(height: 20,),
//                FlatButton(
//                  child: Text("Add Funds"),
//                  onPressed: () {
//                    DonateLogic logic = DonateLogic(myAccount: myAccount);
//                    logic.addFunds(userPair.secretSeed);
//                  },
//                ),
              ],
            ),],),
    );
  }

}
