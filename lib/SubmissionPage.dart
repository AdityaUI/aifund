import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubmissionPage extends StatefulWidget {
  SubmissionPage({Key key, this.uid}) : super(key: key);

  final String uid;

  @override
  _SubmissionPageState createState() => _SubmissionPageState();
}

class _SubmissionPageState extends State<SubmissionPage> {
  List<TextEditingController> list = [new TextEditingController(), new TextEditingController(), new TextEditingController(), new TextEditingController(), new TextEditingController(), new TextEditingController(),];
  String _myCause = "";
  final GlobalKey<FormState> _assistanceFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Submit a need"),
        ),
        body: Column(
          children: <Widget>[
            Form(
              key: _assistanceFormKey,
              child: Column(
                children: <Widget>[
                  DropDownFormField(
                    titleText: 'My Cause',
                    hintText: 'Please choose one',
                    value: _myCause,
                    onSaved: (value) {
                      setState(() {
                        _myCause = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _myCause = value;
                      });
                    },
                    dataSource: [
                      {
                        "display": "Heart Disease",
                        "value": "Heart Disease",
                      },
                      {
                        "display": "Cancer",
                        "value": "Cancer",
                      },
                      {
                        "display": "Dementia",
                        "value": "Dementia",
                      },
                      {
                        "display": "Sickle Cell Anemia",
                        "value": "Sickle Cell Anemia",
                      },
                      {
                        "display": "Progeria",
                        "value": "Progeria",
                      },
                      {
                        "display": "ALS (Lou Gehrig’s)",
                        "value": "ALS (Lou Gehrig’s)",
                      },
                      {
                        "display": "HIV",
                        "value": "HIV",
                      },
                      {
                        "display": "Alzheimer's",
                        "value": "Alzheimer's",
                      },
                      {
                        "display": "Parkinson’s",
                        "value": "Parkinson’s",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Age*', hintText: "15"),
                    controller: list[0],
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Terminality*', hintText: "10"),
                    controller: list[1],
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Income*', hintText: "50000"),
                    controller: list[2],
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Funds*', hintText: "1000"),
                    controller: list[3],
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Success Chance*', hintText: "75"),
                    controller: list[4],
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Cost*', hintText: "5000"),
                    controller: list[5],
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            FlatButton(
              child: Text("Submit"),
              onPressed: () {
                Firestore.instance.collection("applications").document(widget.uid)
                    .setData({
                  "age": list[0].text,
                  "cause": _myCause,
                  "cost":list[5].text,
                  "funds":list[3].text,
                  "income":list[2].text,
                  "success chance":list[4].text,
                  "terminality":list[1].text,
                });
                Navigator.pop(context);
              },
            )
          ],
        ));
  }
}
