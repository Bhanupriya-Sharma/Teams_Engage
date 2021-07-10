import 'package:flutter/material.dart';

import 'src/index.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _app = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We-Link (Teams)',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: FutureBuilder(
        future: _app,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("ERROR");
          } else if (snapshot.hasData) {
            return IndexPage();
          } else {
            return Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Colors.deepPurple,
                  strokeWidth: 4.0),
            );
          }
        },
      ),
    );
  }
}

///PROCEDURE OF THE CODE
///One opens the app and Firebase app gets initialised (internet on)
///One reaches to the index page where there are two buttons: Join and Create
///Index page also has Text Fields for MeetingID and Password
///Join button is for the users who have MeetingID and password shared by the Meeting Owner
///One enters the meeting credentials and Call Page is called and user enters the meeting
///If one clicks on Create button, Create page is called
///On Create Page, is a text field for creating a password for an automatically generated meetingID and SHARE button
///The password is mapped on the firestore database and a sharable text box appears on clicking SHARE button
///After sharing the credentials one can click on the Join button (on the position of SHARE button)
///Call page is again called and one enters the meeting
