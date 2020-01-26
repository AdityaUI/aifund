import 'package:flutter/material.dart';
import 'package:stellar/stellar.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:http/http.dart' as http;


class DonateLogic {

  DonateLogic({Key key, this.myAccount});

  AccountResponse myAccount;

  void sendFunds(String secret, String to) {
    Network.useTestNetwork();
    Server server = new Server("https://horizon-testnet.stellar.org");

    KeyPair myKp = KeyPair.fromSecretSeed(secret);
    KeyPair toKp = KeyPair.fromAccountId(to);
    Transaction transaction = new TransactionBuilder(myAccount)
        .addOperation(new PaymentOperationBuilder(
        toKp, new AssetTypeNative(), "1000")
        .build())
        .addMemo(Memo.text("Test Transaction"))
        .build();
    transaction.sign(myKp);

    server.submitTransaction(transaction).then((response) {
      print("Success!");
      print(response);
    }).catchError((error) {
      print("Something went wrong!");
    });
  }


  void addFunds(String secret) async {
    KeyPair kp = KeyPair.random();
    var url = "https://friendbot.stellar.org/?addr=${kp.accountId}";
    await http.get(url);

    Network.useTestNetwork();
    Server server = new Server("https://horizon-testnet.stellar.org");

    server.accounts.account(kp).then((account) {
      Transaction transaction = new TransactionBuilder(account)
          .addOperation(new PaymentOperationBuilder(
          KeyPair.fromSecretSeed(secret), new AssetTypeNative(), "1000")
          .build())
          .addMemo(Memo.text("Test Transaction"))
          .build();
      transaction.sign(kp);
      server.submitTransaction(transaction);
    });

  }

}
