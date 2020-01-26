import 'package:flutter/material.dart';
import 'package:codedecoders/DonateLogic.dart';
import 'package:codedecoders/DonateAccounts.dart';
import 'package:stellar/stellar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DonationPage extends StatefulWidget {
  DonationPage(
      {Key key, this.cause, this.description, this.userPair, this.myAccount})
      : super(key: key);

  KeyPair userPair;
  AccountResponse myAccount;
  String cause;
  String description;

  @override
  _DonationState createState() => _DonationState();
}

class _DonationState extends State<DonationPage> {
  String amtValidator(String value) {
    if (value.trim().contains("\D")) {
      return "Please enter a number";
    } else {
      return null;
    }
  }

  final GlobalKey<FormState> _amtFormKey = GlobalKey<FormState>();
  TextEditingController amountInputController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donate funds to help cure " + widget.cause),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            widget.cause,
            style: TextStyle(fontSize: 25),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              widget.description,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Form(
            key: _amtFormKey,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                decoration:
                    InputDecoration(labelText: 'Amount*', hintText: "1000"),
                controller: amountInputController,
                validator: amtValidator,
              ),
            ),
          ),
          FlatButton(
            child: Text("Donate"),
            onPressed: () async {
              if (_amtFormKey.currentState.validate()) {
                DonateLogic logic = DonateLogic(myAccount: widget.myAccount);
                print('here');
                logic.sendFunds(
                    "SA6Q3BN75KH67LNXIUJWERKDNHRYJQ6UWTSIMRHIMU5VRAADBOVNCYMN",
                    DonateAccounts().AccountIds[
                        DonateAccounts().causes.indexOf(widget.cause)],
                    amountInputController.text);
                Fluttertoast.showToast(
                    msg: "Submitted!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }
}
