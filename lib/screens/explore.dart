import 'package:codedecoders/DonateAccounts.dart';
import 'package:codedecoders/screens/DonationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:stellar/stellar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Explore extends StatefulWidget {
  Explore({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  KeyPair userPair;
  AccountResponse myAccount;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((value) {
      Firestore.instance
          .collection("users")
          .document(value.uid)
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
    });
  }

  Future<AccountResponse> loginStellar() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot firestore =
        await Firestore.instance.collection("users").document(user.uid).get();
    userPair = KeyPair.fromAccountId(firestore.data["Public Key"].toString());
    myAccount = await Server("https://horizon-testnet.stellar.org")
        .accounts
        .account(KeyPair.fromAccountId(firestore.data["Public Key"]));
    return myAccount;
  }

  void checkPayment() async {
    DonateAccounts accounts = new DonateAccounts();
    Network.useTestNetwork();
    Server server = Server("https://horizon-testnet.stellar.org");
    for (int i = 0; i < accounts.AccountIds.length; i++) {
      print("i: " + i.toString());
      KeyPair pair = KeyPair.fromAccountId(accounts.AccountIds[i]);
      server.accounts.account(pair).then((account) {
        if (double.parse(account.balances[0].balance) > 1000) {

        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: FutureBuilder(
      future: (loginStellar()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          return Stack(
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
                    material.Row(
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
                                    description: "As the second most common cause of death in the United States, "
                                        "cancer devastates the lives of patients and their families each "
                                        "and every year. There are a myriad of cancers and each one is as deadly "
                                        "as the next. Help us fund treatment for a person desperately in need by donating today.",
                                userPair: userPair,
                                myAccount: myAccount,
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
                                    description: "Imagine slowly forgetting everything you know and everyone you love. "
                                        "The memories you spent your For patients suffering from dementia, "
                                        "this is the tragic reality in which they are forced to live. An entire lifetime "
                                        "spent making memories is rendered useless and eventually, the patient loses all sense of identity. "
                                        "Donate today to give much needed aid to someone suffering from dementia. ",
                                userPair: userPair,
                                myAccount: myAccount,
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
                                    description: "bb",
                                    userPair: userPair,
                                    myAccount: myAccount,
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
                child: Column(
                  children: [
                    Flexible(
                      child: ListView(
                        children: <Widget>[
                          ListTile(
                            trailing: Icon(Icons.more_vert),
                            leading: Image.asset("assets/ad1.png"),
                            title: Text("Heart Disease",
                                style: TextStyle(
                                    fontFamily: "CentraleSansRegular",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                "The leading cause of death for both men and women each year.",
                                style: TextStyle(
                                  fontFamily: "CentraleSansRegular",
                                  fontSize: 15,
                                )),
                            onTap: () {
                              Navigator.push(
                                context,
                                  MaterialPageRoute(
                                    builder: (context) => DonationPage(
                                          cause: "Heart Disease",
                                          description: "As the leading cause of death for both men and women each year,"
        "heart disease claims the most lives nationally and internationally."
        "The most common cause of heart disease, atherosclerosis, "
        "is a result of an unhealthy diet and a sedentary lifestyle. "
        "Consider donating today to help us continue treating heart disease patients in "
        "dire need of your assistance.",
                                      userPair: userPair,
                                      myAccount: myAccount,
                                        )),
                              );
                            },
                          ),
                          ListTile(
                            trailing: Icon(Icons.more_vert),
                            leading: Image.asset("assets/ad2.png"),
                            title: Text("Sickle Cell Anemia",
                                style: TextStyle(
                                    fontFamily: "CentraleSansRegular",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                "Sickle cell anemia affects more than 200,000 Americans.",
                                style: TextStyle(
                                  fontFamily: "CentraleSansRegular",
                                  fontSize: 15,
                                )),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DonationPage(
                                          cause: "Sickle Cell Anemia",
                                          description: "Sickle cell anemia, an inherited blood disorder affecting more than 200,000 "
                                              "Americans, causes a lifetime of pain for the afflicted patient. "
                                              "Red blood cells within the patient’s body become a sickly sickle shape "
                                              "as a result of the disease, resulting in oxygen deprivation and severe blood flow "
                                              "reduction. Please consider donating to help someone affected by sickle cell anemia.",
                                      userPair: userPair,
                                      myAccount: myAccount,
                                        )),
                              );
                            },
                          ),
                          ListTile(
                            trailing: Icon(Icons.more_vert),
                            leading: Image.asset("assets/ad3.png"),
                            title: Text("Parkinson’s",
                                style: TextStyle(
                                    fontFamily: "CentraleSansRegular",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                "How does it feel to experience constant shaking with slow limb movement and impaired posture?",
                                style: TextStyle(
                                  fontFamily: "CentraleSansRegular",
                                  fontSize: 15,
                                )),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DonationPage(
                                          cause: "Parkinson’s",
                                          description: "How does it feel to experience constant shaking with slow"
        "limb movement and impaired posture? A Parkinson’s disease patient"
        "aces the daily challenges of coping with limited cognitive and movement abilities, "
        "such as depression, deprived thinking speed, and irrational sleep patterns. "
        "With your dedication, we can aid donation in order to initiate therapies and "
        "medications for Parkinson’s patients, possibly limiting the symptoms.",
                                      userPair: userPair,
                                      myAccount: myAccount,
                                        )),
                              );
                            },
                          ),
                          ListTile(
                            trailing: Icon(Icons.more_vert),
                            leading: Image.asset("assets/ad3.png"),
                            title: Text("Diabetes",
                                style: TextStyle(
                                    fontFamily: "CentraleSansRegular",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                "A disease with no cure.",
                                style: TextStyle(
                                  fontFamily: "CentraleSansRegular",
                                  fontSize: 15,
                                )),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DonationPage(
                                          cause: "HIV",
                                          description: "Imagine you are diagnosed with a disease whose cure is non-existent "
        "only with a substitute that offers temporary treatment. HIV (Human Immunodeficiency Virus) "
        "is a virus that destroys the body’s white blood cells, which, in turn, weakens the"
        " human’s immune system’s ability to obliterate various diseases. As of today, the "
        "only solution is to seek immediate treatment and take proper medication in order to "
        "deteriorate the virus’s continuous rate of spreading. With nothing to start from, this"
        "doesn’t inhibit the idea of funding money towards a successful research "
        "that would make HIV extinct. With your dedication and donation, together,"
        " we can facilitate the research to make HIV extinct, a pathway to support the life of a patient. ",
                                      userPair: userPair,
                                      myAccount: myAccount,
                                        )),
                              );
                            },
                          ),
                          ListTile(
                            trailing: Icon(Icons.more_vert),
                            leading: Image.asset("assets/ad3.png"),
                            title: Text("ALS (Lou Gehrig’s)",
                                style: TextStyle(
                                    fontFamily: "CentraleSansRegular",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                "Imagine experiencing weakening muscles and slower cognitive functioning to the extent where you are completely paralyzed. ",
                                style: TextStyle(
                                  fontFamily: "CentraleSansRegular",
                                  fontSize: 15,
                                )),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DonationPage(
                                          cause: "ALS (Lou Gehrig’s)",
                                          description: "Imagine experiencing weakening muscles and slower cognitive functioning to"
                                    "the extent where you are completely paralyzed. ALS (Lou Gehrig’s disease)"
                                    "degenerates the amount of motor neurons in the central nervous system as "
                                    "well as obliterating muscle functions for various organs(breathing difficulties, "
                                    "impaired balance, etc.) Continue donating money in order to initiate ideas for"
                                      "assisting ALS patients. ",
                                      userPair: userPair,
                                      myAccount: myAccount,
                                        )),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return CircularProgressIndicator();
      },
    ));
  }
}
