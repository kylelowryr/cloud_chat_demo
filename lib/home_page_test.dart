import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_groupproject/pages/chat_screen.dart';
import 'package:my_app_groupproject/pages/post_page.dart';

class HomePagetest extends StatefulWidget {
  HomePagetest({Key key}) : super(key: key);

  @override
  _HomePagetestState createState() {
    return _HomePagetestState();
  }
}

class _HomePagetestState extends State<HomePagetest> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f0e6),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 10,
              right: 0,
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.search_outlined),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return ChatScreen();
                          },
                        ));
                      }),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.mail_outline),
                      onPressed: () {

                      }),
                  IconButton(icon: Icon(Icons.add_alert), onPressed: () {}),
                  CircleAvatar(
                    radius: 18,
                  ),
                  Container(
                    width: 10,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              bottom: 100,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  Container(
                      child: Text(
                          '123'
                      )
                  ),
                  CloudsStream(),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 110,
              right: 0,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    height: 40,
                    width: 140,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return Posts();
                                },
                              ));
                            },
                            child: Text('Post a Cloud',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ))),
                      ],
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.apps_outlined),
                    iconSize: 45,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CloudsStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('cloud')
          .orderBy('date')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final clouds = snapshot.data.docs;

        List<CloudBubble> CloudBubbles = [];

        for (var cloud in clouds) {
          final cloudTitle = cloud.data()['Title'] ?? '';

          final cloudBody = cloud.data()['Body'] ?? '';
          final cloudUsername = cloud.data()['Username'] ?? '';



          final cloudBubble = CloudBubble(
              Title: cloudTitle,
              Body: cloudBody,
              Username:cloudUsername

          );
          if (cloudTitle != '' || cloudBody != '') {
            CloudBubbles.add(cloudBubble);

          }
        }
        if (CloudBubbles.isNotEmpty) {
          print("not emp 1");
        } else {
          print("emp 1");
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: CloudBubbles,
          ),
        );
      },
    );
  }
}

class CloudBubble extends StatelessWidget {
  CloudBubble(
      {this.Title,
        this.Body,
        this.Date,
        this.Username,
        this.PostId,
        this.OwnerId});

  final String Title;
  final String Body;
  final String Username;
  final String OwnerId;
  final String PostId;
  final Timestamp Date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Username,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(15),
            elevation: 5.0,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                children: [
                  Text(
                    Username,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    Title,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 17.0,
                    ),
                  ),
                  Text(
                    Body,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
