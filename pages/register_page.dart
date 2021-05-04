import 'package:flutter/material.dart';
import 'package:my_app_groupproject/pages/root_page.dart';

import '../signin_google_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  State createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
            BackButton(),
            _GoogleSignInButton(),
          ])
    ]));
  }
  Widget _GoogleSignInButton() {
    return OutlinedButton(

        onPressed: () {
      signInWithGoogle().then((result) {
        if (result != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return RootPage();
              },
            ),
          );
        }
      });
    }
    );
  }
}
