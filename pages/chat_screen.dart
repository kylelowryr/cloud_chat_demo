import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app_groupproject/home_page.dart';
import 'package:my_app_groupproject/signin_google_page.dart';

GoogleSignInAccount loggedInUser;
String postid11;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  ChatScreen({Key key, @required this.PostId,@required this.OwnerId}) : super(key: key);
  final String PostId;
  final String OwnerId;





  @override
  _ChatScreenState createState() => _ChatScreenState();

}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;


  String PostId1;
  String OwnerId;
  String clpostId;
  String messageText;

  @override
  void initState() {
    super.initState();
    
    postid11 = widget.PostId;
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await getGoogleUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Chat'),
        backgroundColor: Colors.green

      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.green),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {

                      messageTextController.clear();

                      FirebaseFirestore.instance.collection('cloud').doc(widget.PostId).collection('message').add({
                        'text': messageText,
                        'sender': loggedInUser.displayName,
                        'receiver':widget.OwnerId,
                        'date': Timestamp.now(),
                      });
                    },
                    child: Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
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

class MessagesStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('cloud')
          .doc(postid11)
          .collection('message')
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
        final messages = snapshot.data.docs.reversed;
        List<MessageBubble> messageBubbles = [];

        for (var message in messages) {
          final messageText = message.data()['text'] ?? '';

          final messageSender = message.data()['sender'] ?? '';
          final messageReceiver = message.data()['receiver'] ?? '';
          final currentUser = loggedInUser.displayName;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            receiver: messageReceiver,
            isMe: currentUser == messageSender,
          );
          if (messageSender != '' || messageText != '') {
            messageBubbles.add(messageBubble);
          }
        }
        if (messageBubbles.isNotEmpty) {
          print("not emp");
        } else {
          print("emp");
        }

        return Expanded(
          child: ListView(

            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe, this.date,this.receiver});
  final String receiver;
  final String sender;
  final String text;
  final bool isMe;
  final Timestamp date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(30),

            elevation: 5.0,
            color: isMe ? Colors.green : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
