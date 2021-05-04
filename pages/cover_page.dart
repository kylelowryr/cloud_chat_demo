import 'package:flutter/material.dart';

class CoverPage extends StatefulWidget {
  CoverPage({Key key}) : super(key: key);

  @override
  _CoverPageState createState() {
    return _CoverPageState();
  }
}

class _CoverPageState extends State<CoverPage> {
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
      body:Stack(
       children: [
         Image.asset(
           'assets/images/Cloud.webp',
           fit:BoxFit.cover,
           width:MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height,
         ),

       ],
      ),
    );
  }
}
