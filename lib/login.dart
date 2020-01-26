import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codedecoders/homePage.dart';
import 'package:codedecoders/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _loginFormKey = new GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/image1.png"),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter)),
        child: Form(
          key: _loginFormKey,
          child: ListView(
            padding: EdgeInsets.all(10),
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.15,
              ),
              TextFormField(
                controller: emailInputController,
                style: TextStyle(
                    color: Colors.black, fontFamily: "CentraleSansRegular"),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Color(0xffd3dde4), width: 3)),
                    labelText: "Email",
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "CentraleSansRegular")),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: pwdInputController,
                obscureText: true,
                style: TextStyle(
                    color: Colors.black, fontFamily: "CentraleSansRegular"),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Color(0xffd3dde4), width: 3)),
                    labelText: "Password",
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: "CentraleSansRegular")),
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                child: Container(
                  width: 330,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff471a91), Color(0xff3cabff)],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "CentraleSansRegular",
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onPressed: () {
                  print("Pressed");
                  if (_loginFormKey.currentState.validate()) {
                    print("login");
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailInputController.text,
                            password: pwdInputController.text)
                        .then((currentUser) => Firestore.instance
                            .collection("users")
                            .document(currentUser.user.uid)
                            .get()
                            .then((DocumentSnapshot result) =>
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage(uid: currentUser.user.uid,)),
                        ))
                            .catchError((err) => print(err)))
                        .catchError((err) => print(err));
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                "Forgot Password?",
                style: TextStyle(
                    fontFamily: 'CentraleSansRegular',
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              )),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                minWidth: 330,
                height: 70,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Color(0xff00b4ff), width: 3)),
                onPressed: () {},
                child: FlatButton(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        LineAwesomeIcons.registered,
                        color: Color(0xff00b4ff),
                        size: 40,
                      ),
                      Text(
                        "Register",
                        style: TextStyle(
                            color: Color(0xff00b4ff),
                            fontFamily: "CentraleSansRegular",
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }
}
