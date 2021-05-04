import 'package:flutter/material.dart';
import 'package:my_app_groupproject/home_page.dart';
import 'package:my_app_groupproject/pages/post_page.dart';
import 'package:my_app_groupproject/pages/root_page.dart';

import '../signin_google_page.dart';
import 'chat_screen.dart';

class LogInPage extends StatefulWidget {
  @override
  State createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _emailaddressController =
      new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(children: <Widget>[
      Opacity(
          opacity: 0.2,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/images/Cloud.webp'),
                fit: BoxFit.cover,
              ),
            ),
          )),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image(
              image: AssetImage("assets/images/cloud_slogan2.png"),
              fit: BoxFit.cover,
            ),
            height: 500,
            width: 500,
          ),
          Container(
            child: _GoogleSignInButton(),
          ),
          Spacer(),
        ],
      )
    ]));
  }

  Widget _GoogleSignInButton() {
    return TextButton(
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );
          }
        });
      },
      child: Container(
        height: 50,
        width: 220,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Colors.blueAccent, Colors.greenAccent],
          ),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 8),
                color: const Color(0x33D83131),
                blurRadius: 20)
          ],
          borderRadius: BorderRadius.circular(24),
          color: Theme.of(context).accentColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/images/google_logo.png"),
                height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                child: new Text("Log In with Google",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
