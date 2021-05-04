

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'package:meta/meta.dart';
import 'package:my_app_groupproject/signin_google_page.dart';

class Profiles extends StatefulWidget {
  const Profiles({
    this.userId,
    this.gender,
    this.education,
    this.birthday,
    this.religion,
    this.nationality,
    this.time,
    });

  factory Profiles.fromDocument(DocumentSnapshot document) {
    return Profiles(
      userId: document['userId'],

      gender: document['gender'],
      education: document['education'],
      birthday: document['birthday'],
      religion: document['religion'],
      nationality: document['nationality'],
      time:document['time'],
    );
  }

  factory Profiles.fromJSON(Map data) {
    return Profiles(
      userId: data['userId'],

      gender: data['gender'],
      education: data['education'],
      birthday: data['birthday'],
      religion: data['religion'],
      nationality: data['nationality'],
      time: data['time'],
    );
  }

  final String userId;
  final String gender;
  final String education;
  final String birthday;
  final String religion;
  final String nationality;
  final Timestamp time;

  _Profiles createState() => _Profiles(

    userId: this.userId,
    gender: this.gender,
    education: this.education,
    birthday: this.birthday,

    religion: this.religion,
    nationality: this.nationality,
    time:this.time,
  );
}


class _Profiles extends State<Profiles> {
  final GlobalKey<FormState> _formkey = GlobalKey();


  final String userId;
  final String gender;
  final String education;
  final String birthday;
  final String religion;

  final String nationality;
  final Timestamp time;

  var reference2 = FirebaseFirestore.instance.collection('profiles');

  _Profiles(
      {
        this.userId,
        this.gender,
        this.education,

        this.birthday,
        this.religion,
        this.nationality,
        this.time});








  String _Gender;
  String _Birthday;
  String _Religion;
  String _Education;
  String _Nationality;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f0e6),
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: ListView(

        children: [


            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Gender",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(right: 15, left: 15),
                    ),
                    onChanged: (value) => _Gender= value,
                    onSaved: (val) => _Gender = val,
                    validator: (val) {
                      if (val.isEmpty) {
                        return null;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "birthday",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(
                          right: 15, left: 10),
                    ),
                    maxLines: 1,
                    onChanged: (value) => _Birthday = value,
                    onSaved: (val) => _Birthday = val,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Body field can't be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Religion",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(
                          right: 15, top: 15, left: 10),
                    ),
                    maxLines: 1,
                    onChanged: (value) => _Religion = value,
                    onSaved: (val) => _Religion = val,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Body field can't be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Education",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(
                          right: 15, top: 15, left: 10),
                    ),
                    maxLines: 1,
                    onChanged: (value) => _Education = value,
                    onSaved: (val) => _Education = val,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Body field can't be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Nationality",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.only(
                          right: 15, top: 15, left: 10),
                    ),
                    maxLines: 1,
                    onChanged: (value) => _Nationality = value,
                    onSaved: (val) => _Nationality = val,
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

                            addProfile();
                          },
                          child: Text(
                            'Update Profile',
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

          )
        ],
      ),
    );
  }

  void addProfile() {



    FirebaseFirestore.instance
        .collection('profiles')
        .doc(getGoogleUserId(),)
        .collection('profile')
        .doc()
        .set({
      "userId": getGoogleUserId(),
      "gender":_Gender,
      "birthday":_Birthday,
      "education": _Education,
      "religion": _Religion,
      "nationality":_Nationality,
      "time":Timestamp.now()
    });

    Navigator.pop(context);
  }
}