
import 'package:flutter/material.dart';
import 'package:flutter_doroti/helpers/style.dart';

class Splash extends StatelessWidget {

  Widget build(BuildContext context) {
                              ////Borrar
    return Scaffold(

      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          CircularProgressIndicator()
        ],
      ),

    );
  }
}