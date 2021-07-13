import 'dart:async';
import 'dart:math';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import './call.dart';
import './Drawer.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole? _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(
            'We-Link (Teams)',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              _mainView(),
              _image(),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        drawer: MyDrawer(name: "Bhanupriya"));
  }

  Widget _image() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(55, 200, 10, 20),
      child: SizedBox(
        width: 300.0,
        height: 300.0,
        child: Image(
          image: AssetImage(
            'assets/images/frontpage.jpg',
          ),
          width: 20.0,
          height: 50.0,
          //scale: 2,
        ),
      ),
    );
  }

  Widget _mainView() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 90),
      height: 600,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ///Field for Meeting Code received from meeting owner
              Expanded(
                child: TextField(
                  controller: _channelController,
                  decoration: InputDecoration(
                    errorText:
                        _validateError ? 'Meeting Code is necessary' : null,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(width: 5),
                    ),
                    hintText: 'Enter Meeting Code',
                  ),
                ),
              ),
            ],
          ),

          ///Buttons: JOIN and CREATE
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  ///Join Button
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: onJoin,
                      child: Text(
                        'Join',
                        style: TextStyle(
                            fontSize: 23.0, fontWeight: FontWeight.w400),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.deepPurple),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white)),
                    ),
                  ),
                ),

                ///Create Button
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RaisedButton(
                      onPressed: () {
                        showAlertDialog(context);
                        onCreate();
                      },
                      child: Text(
                        'Create',
                        style: TextStyle(
                            fontSize: 23.0, fontWeight: FontWeight.w400),
                      ),
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onCreate() async {
    var _code = getRandomString(10);
    TextField(
      controller: _channelController,
    );
    setState(() {
      _channelController.text = _code;
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("PLEASE"),
      content: Text("Copy this ID and share with friends to invite them."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> onJoin() async {
    // update input validation
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
          ),
        ),
      );
    }
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
