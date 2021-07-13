import 'package:flutter/material.dart';
import 'package:quick_feedback/quick_feedback.dart';
import 'help.dart';

class MyDrawer extends StatefulWidget {
  final String? name;

  const MyDrawer({Key? key, this.name}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  color: Colors.deepPurple,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      "TEAMS",
                      style: TextStyle(
                          fontSize: 27.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.announcement_outlined,
                      size: 30.0, color: Colors.deepPurple),
                  title: Text(
                    "Send Feedback",
                    style: TextStyle(fontSize: 22.0),
                  ),
                  onTap: () {
                    _showFeedback(context);
                  },
                ),
                ListTile(
                  leading:
                      Icon(Icons.help, size: 30.0, color: Colors.deepPurple),
                  title: Text(
                    "Help",
                    style: TextStyle(fontSize: 22.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => helpPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFeedback(context) {
    showDialog(
      context: context,
      builder: (context) {
        return QuickFeedback(
          title: 'Leave a feedback', // Title of dialog
          showTextBox: true, // default false
          textBoxHint:
              'Share your feedback', // Feedback text field hint text default: Tell us more
          submitText: 'SUBMIT', // submit button text default: SUBMIT
          onSubmitCallback: (feedback) {
            print('$feedback'); // map { rating: 2, feedback: 'some feedback' }
            Navigator.of(context).pop();
          },
          askLaterText: 'Nevermind',
          onAskLaterCallback: () {
            print('Do something on ask later click');
          },
        );
      },
    );
  }
}
