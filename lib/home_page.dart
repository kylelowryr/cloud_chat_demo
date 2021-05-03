import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app_groupproject/home_page_test.dart';
import 'package:my_app_groupproject/pages/chat_screen.dart';
import 'package:my_app_groupproject/pages/login_page.dart';
import 'package:my_app_groupproject/pages/post_page.dart';
import 'package:my_app_groupproject/signin_google_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
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

                      }),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.mail_outline),
                      onPressed: () {



                      }),
                  IconButton(icon: Icon(Icons.add_alert), onPressed: () {}),
                  GoogleUserCircleAvatar(identity: getGoogleUser(),foregroundColor: Colors.blueAccent,)

                  ,
                  Container(
                    width: 10,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 60,
              bottom: 80,
              left: 10,
              right: 10,
              child: Column(
                children: [

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
                    onPressed: () {
                      signOutGoogle();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return LogInPage();
                        },
                      ));
                    },
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
        print("*******clouds length********");
        print(clouds.length);
        print("*****************");
        List<CloudBubble> cloudBubbles = [];
        int index = 0;

        for (var cloud in clouds) {
          final cloudTitle = cloud.data()['title'] ?? '';

          final cloudBody = cloud.data()['body'] ?? '';
          final cloudUsername = cloud.data()['username'] ?? '';
          final cloudPostId = cloud.data()['postId'] ?? '';


          final cloudBubble = CloudBubble(
            Title: cloudTitle,
            Body: cloudBody,
            Username:cloudUsername

          );

          List<String> postIdList = [];
          if (cloudTitle != '' || cloudBody != '') {
            cloudBubbles.add(cloudBubble);

          }

        }


        if (cloudBubbles.isNotEmpty) {
          print("not emp 1");
        } else {
          print("emp 1");
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: cloudBubbles,


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

  String postIdcur;

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
            elevation: 5,

            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(

                    children: <Widget>[
                      Container(
                        width: 195,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Title,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 11.0,
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
                    ],
                  ),

                  TextButton(
                      onPressed: (){

                        print(PostId);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return ChatScreen(PostIdNow: PostId,OwnerId: OwnerId,);
                          },
                        ));
                      },
                      child: Text(
                        'Chat'
                      ))
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
}


