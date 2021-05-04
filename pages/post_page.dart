import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'package:meta/meta.dart';
import 'package:my_app_groupproject/signin_google_page.dart';

class Posts extends StatefulWidget {
  const Posts({
    this.username,
    this.title,
    this.body,
    this.date,
    this.postId,
    this.ownerId});

  factory Posts.fromDocument(DocumentSnapshot document) {
    return Posts(
      username: document['username'],

      title: document['title'],
      date: document['date'],
      body: document['body'],
      postId: document.id,
      ownerId: document['ownerId'],
    );
  }

  factory Posts.fromJSON(Map data) {
    return Posts(
      username: data['username'],
      title: data['title'],

      date: data['date'],
      body: data['body'],
      ownerId: data['ownerId'],
      postId: data['postId'],
    );
  }

  final String username;
  final String title;
  final String body;
  final Timestamp date;
  final String postId;
  final String ownerId;

  _Posts createState() => _Posts(

    username: this.username,
    title: this.title,
    body: this.body,
    date: this.date,

    ownerId: this.ownerId,
    postId: this.postId,
  );
}


class _Posts extends State<Posts> {
  final GlobalKey<FormState> _formkey = GlobalKey();


  final String username;
  final String title;
  final String body;
  final Timestamp date;
  final String postId;

  final String ownerId;

  var reference1 = FirebaseFirestore.instance.collection('cloud');

  _Posts(
      {
        this.username,
        this.title,
        this.body,

        this.postId,
        this.date,
        this.ownerId});








  String _Title;
  String _Body;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f0e6),
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Post Title",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(right: 15, left: 15),
                    ),
                    onChanged: (value) => _Title= value,
                    onSaved: (val) => _Title = val,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Title filed can't be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Post Body",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(
                          right: 15, top: 15, bottom: 50, left: 15),
                    ),
                    maxLines: 7,
                    onChanged: (value) => _Body = value,
                    onSaved: (val) => _Body = val,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Body field can't be empty";
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 150,
                  ),
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

                            addPost();
                          },
                          child: Text(
                            'Post a Cloud',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void addPost() {
      String _id = reference1.doc().id;


      FirebaseFirestore.instance
        .collection('cloud')
        .doc(_id)
        .set({
          "username": getGoogleUserName(),
          "title":_Title,
          "body":_Body,
          "date": Timestamp.now(),
          "ownerId": getGoogleUserId(),
          "postId": _id
      });

      Navigator.pop(context);
    }
}

