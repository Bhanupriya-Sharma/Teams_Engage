import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'DocFirestoreSearch.dart' as DFS;

class CreatePage extends StatefulWidget {
  final String? channelName;

  /// Creates a call page with given channel name.
  const CreatePage({Key? key, this.channelName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _info();
}

class _info extends State<CreatePage> {
  final text = TextEditingController();
  late String password;

  ///Function to get credentials of meeting on creating a meeting
  Widget showCredentials(String? MeetingID, String? Password) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Center(child: SelectableText('Meeting ID:')),
            Center(child: SelectableText(MeetingID!)),
          ],
        ),
        Row(
          children: [
            Center(child: SelectableText('Password:')),
            Center(child: SelectableText(Password!)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("We-Link (Teams)"),
      ),
      body: Container(
        height: 600,
        child: Column(
          children: [
            TextFormField(
              controller: text,
              decoration: InputDecoration(
                  errorText: "Password is necessary",
                  border: OutlineInputBorder(),
                  hintText: "Create a Password for your meeting"),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            Row(
              children: [
                ///Button to show the credentials on screen
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 90),
                    child: RaisedButton(
                      onPressed: () async {
                        ///Add Data to Firestore
                        await FirebaseFirestore.instance
                            .collection('Meetings')
                            .add({
                          'MeetingID': widget.channelName,
                          'Password': password
                        });

                        ///Show on Screen
                        showCredentials(widget.channelName, password);
                      },
                      child: Text(
                        'Share ID',
                        style: TextStyle(
                            fontSize: 23.0, fontWeight: FontWeight.w400),
                      ),
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                    ),
                  ),
                ),

                ///Button to join with Credentials
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 90),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Join',
                        style: TextStyle(
                            fontSize: 23.0, fontWeight: FontWeight.w400),
                      ),
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
