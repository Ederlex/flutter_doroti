import 'package:flutter_doroti/helpers/style.dart';
import 'package:flutter_doroti/pantallas/splash.dart';
import 'package:flutter_doroti/providers/auth.dart';
import 'package:flutter_doroti/widgets/custom_button.dart';
import 'package:flutter_doroti/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() =>  _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController number = TextEditingController();
  TextEditingController name = TextEditingController();                       //Borrar
  TextEditingController surname = TextEditingController();                    //Borrar
  TextEditingController email = TextEditingController();                      //Borrar

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body:  SingleChildScrollView(
          child: auth.loading ? Splash() : Column(mainAxisAlignment: MainAxisAlignment.center, children: [

            SizedBox(
              height: 30,
              width: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/photo.jpg",
                  width: 160,
                ),
              ],
            ),
            SizedBox(height: 10,
                     width: 50,),
            CustomText(text: "Lo Hacemos por ti", size: 28, weight: FontWeight.bold),
            SizedBox(height: 5, // sin ,
                    width: 30,),
            RichText(
                text: TextSpan(children: [
                  TextSpan(text: "Bien Venidos a "),
                  TextSpan(text: " Doroti", style: TextStyle(color: Colors.blue.shade900)),
                  TextSpan(text: " app"),
                ], style: TextStyle(color: black))),

            SizedBox(height: 10,
                     width: 90,), //sin ,
            Padding(
              padding: const EdgeInsets.only(left:12, right: 12, bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                    color: white,
                    border: Border.all(color: black, width: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: grey.withOpacity(0.3),
                          offset: Offset(2, 1),
                          blurRadius: 2
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: TextField(
                    keyboardType: TextInputType.text,              //Borrar text y poner phone
                    controller: number,
                    decoration: InputDecoration(
                        icon: Icon(Icons.phone_android, color: grey),
                        border: InputBorder.none,
                        hintText: "Numero de celular",
                        hintStyle: TextStyle(
                            color: grey,
                            fontFamily: "Sen",
                            fontSize: 18
                        )
                    ),
                  ),
                ),
              ),
            ),


          //Borrar

            SizedBox(height: 10,
              width: 90,), //sin ,
            Padding(
              padding: const EdgeInsets.only(left:12, right: 12, bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                    color: white,
                    border: Border.all(color: black, width: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: grey.withOpacity(0.3),
                          offset: Offset(2, 1),
                          blurRadius: 2
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: TextField(
                    keyboardType: TextInputType.text,              //Borrar text y poner phone
                    controller: name,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person, color: grey),
                        border: InputBorder.none,
                        hintText: "Nombre",
                        hintStyle: TextStyle(
                            color: grey,
                            fontFamily: "Sen",
                            fontSize: 18
                        )
                    ),
                  ),
                ),
              ),
            ),



            SizedBox(height: 10,
              width: 90,), //sin ,
            Padding(
              padding: const EdgeInsets.only(left:12, right: 12, bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                    color: white,
                    border: Border.all(color: black, width: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: grey.withOpacity(0.3),
                          offset: Offset(2, 1),
                          blurRadius: 2
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: TextField(
                    keyboardType: TextInputType.text,              //Borrar text y poner phone
                    controller: surname,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person, color: grey),
                        border: InputBorder.none,
                        hintText: "Apellido",
                        hintStyle: TextStyle(
                            color: grey,
                            fontFamily: "Sen",
                            fontSize: 18
                        )
                    ),
                  ),
                ),
              ),
            ),






            SizedBox(height: 10,
              width: 90,), //sin ,
            Padding(
              padding: const EdgeInsets.only(left:12, right: 12, bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                    color: white,
                    border: Border.all(color: black, width: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: grey.withOpacity(0.3),
                          offset: Offset(2, 1),
                          blurRadius: 2
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: TextField(
                    keyboardType: TextInputType.text,              //Borrar text y poner phone
                    controller: email,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email, color: grey),
                        border: InputBorder.none,
                        hintText: "email",
                        hintStyle: TextStyle(
                            color: grey,
                            fontFamily: "Sen",
                            fontSize: 18
                        )
                    ),
                  ),
                ),
              ),
            ),











            //experimento



            SizedBox(height: 5,
                width: 20,),  //sin,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("AUTENTICACION", textAlign: TextAlign.center, style: TextStyle(color: grey),),
            ),
            SizedBox(height: 10,
                width: 90,),  //sin,
            CustomButton(msg: "Verificar", onTap: (){
              auth.verifyPhoneNumber(context, number.text, name.text, surname.text, email.text);
            })
          ]),
        ),
      ),
    );
  }
}