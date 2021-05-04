import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app_groupproject/home_page.dart';
import 'package:my_app_groupproject/pages/login_page.dart';
import 'package:my_app_groupproject/pages/profile_create.dart';
import 'package:my_app_groupproject/signin_google_page.dart';

class profile extends StatefulWidget {
  profile({Key key, }) : super(key: key);


  @override
  _profileState createState() {
    return _profileState();
  }
}

class _profileState extends State<profile> {
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
      appBar: AppBar(title: Text('Profile'), backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: new Icon(Icons.add),
              highlightColor: Colors.pink,
              onPressed: (){Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return Profiles();
                },
              ));},
            ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 10,
              right: 0,
              child: Row(

                children: [
                  Container(
                    width: 20,
                  ),
                 Container(
                   width: 75,
                   height: 75,
                   child: GoogleUserCircleAvatar(identity: getGoogleUser(),foregroundColor: Colors.blueAccent,



                   ),
                 ),
                  Container(
                    width: 10,
                  ),
                  Container(
                    child:Text(getGoogleUserName(),style: TextStyle(
                      fontSize: 35,
                    ),),
                  ),



                ],
              ),
            ),
            Positioned(
              top: 80,
              bottom: 80,
              left: 10,
              right: 10,
              child: Column(
                children: [

                  ProfilesStream(),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
class ProfilesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('profiles')
          .doc(getGoogleUserId())
          .collection('profile')
          .orderBy('time')

          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final profiles = snapshot.data.docs;
        print("*******clouds length********");
        print(profiles.length);
        print("*****************");
        List<ProfileBubble> profileBubbles = [];
        int index = 0;

        for (var profile in profiles) {
          final profileGender= profile.data()['gender'] ?? '';

          final profileBirthday = profile.data()['birthday'] ?? '';
          final profileReligion = profile.data()['religion'] ?? '';
          final profileEducation = profile.data()['education'] ?? '';
          final profileNationality = profile.data()['nationality'] ?? '';

          index++;
          final profileBubble = ProfileBubble(
            Gender: profileGender,
            Birthday: profileBirthday,
            Education:profileEducation,
            Religion: profileReligion,
            Nationality: profileNationality,
          );


          if (index == profiles.length) {
            profileBubbles.add(profileBubble);

          }

        }




        return Expanded(
          child: ListView(
            reverse: false,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: profileBubbles,


          ),
        );
      },


    );


  }


}

class ProfileBubble extends StatelessWidget {
  ProfileBubble(
      {this.Gender,
        this.Birthday,
        this.Education,
        this.Religion,

        this.Nationality
      });



  final String Gender;
  final String Birthday;
  final String Education;
  final String Religion;
  final String Nationality;






  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

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
                              "Gneder",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 10.0,
                              ),
                            ),
                            Text(
                              Gender,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18.0,
                              ),
                            ),
                            Container(height: 10,),
                            Text(
                              "Birthday",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 10.0,
                              ),
                            ),
                            Text(
                              Birthday,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18.0,
                              ),
                            ),
                            Container(height: 10,),
                            Text(
                              "Education",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 10.0,
                              ),
                            ),
                            Text(
                              Education,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18.0,
                              ),
                            ),
                            Container(height: 10,),
                            Text(
                              "Religion",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 10.0,
                              ),
                            ),
                            Text(
                              Religion,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18.0,
                              ),
                            ),
                            Container(height: 10,),
                            Text(
                              "Nationality",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 10.0,
                              ),
                            ),
                            Text(
                              Nationality,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18.0,
                              ),

                            ),

                          ],
                        ),
                      ),
                    ],
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
