

import 'package:flutter_doroti/widgets/customTextField_homeRegister.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {   //
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _surnameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _numberCelTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView (         //de cupertino a material
      child: Container(

          child: Column(        //de cupertino a material
           mainAxisSize: MainAxisSize.max,
           children: [
            SizedBox(height: 8.0, ),   //de cupertino a material

            Form(                    //de cupertino a material
              key: _formKey,

               child: Column(        //de cupertino a material

                children: [

                  CustomTextFieldRegister(
                    controller: _nameTextEditingController ,
                    data: Icons.person,
                    hintText: "Nombre",

                  ),
                  CustomTextFieldRegister(
                    controller: _surnameTextEditingController ,
                    data: Icons.person,
                    hintText: "Apellidos",

                  ),
                  CustomTextFieldRegister(
                    controller: _emailTextEditingController ,
                    data: Icons.email,
                    hintText: "email",

                  ),
                  CustomTextFieldRegister(
                    controller: _numberCelTextEditingController ,
                    data: Icons.phone,
                    hintText: "numero",

                  ),
                ],
              ),

            ),
            RaisedButton(
              onPressed: ()=>("clicked"),
              color: Colors.redAccent,
              child: Text("Registrar", style: TextStyle(color: Colors.white),),    //de cupertino a material
            ),
            SizedBox(           //de cupertino a material
              height: 30.0,
            ),
            Container(              //de cupertino a material
              height: 4.0,
                                                         // width: _screenWidth * 0.8,
              color: Colors.redAccent,
            ),
            SizedBox(      //de cupertino a material
              height: 15.0,
            ),
          ],
        ),
        ),

    );
  }
}





///////////////////////////

