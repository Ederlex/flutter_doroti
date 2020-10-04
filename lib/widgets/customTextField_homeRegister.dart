import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class CustomTextFieldRegister extends StatelessWidget {   //cupertino a material
  final TextEditingController controller;                 //de cupertino a material
  final IconData data;                          //de cupertino a material
  final String   hintText;


  CustomTextFieldRegister(
  {Key key, this.controller, this.data, this.hintText }
      ) : super(key:key);

  Widget build(BuildContext context){

    return Container(
      decoration: BoxDecoration(
       color: Colors.white,
         borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
         padding: EdgeInsets.all(8.0),
         margin: EdgeInsets.all(10.0),

         child: TextFormField(

          controller: controller,


         cursorColor: Theme.of(context).primaryColor,
         decoration: InputDecoration(

          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Theme.of(context).primaryColor,
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,
        ),

        ),


    );
  }
}