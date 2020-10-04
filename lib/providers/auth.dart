import 'dart:async';
import 'package:flutter_doroti/helpers/screen_navigation.dart';
import 'package:flutter_doroti/helpers/user.dart';
import 'package:flutter_doroti/models/user.dart';
import 'package:flutter_doroti/pantallas/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

class AuthProvider with ChangeNotifier {
  static const LOGGED_IN = "loggedIn";
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;

  //Firestore _firestore = Firestore.instance;
  UserServices _userServices = UserServices();
  UserModel _userModel;
  TextEditingController phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  bool  loggedIn;
  bool  loading = false;

  //getter

  UserModel get userModel => _userModel;
  Status get status => _status;
  FirebaseUser get user => _user;


  AuthProvider.initialize() {
    readPrefs();
  }

  Future<void> readPrefs()async{
    await Future.delayed(Duration(seconds: 3)).then((v) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      loggedIn = prefs.getBool(LOGGED_IN) ?? false;

      if (loggedIn) {
        _user = await _auth.currentUser();
        _userModel = await _userServices.getUserById(_user.uid);
        _status = Status.Authenticated;
        notifyListeners();
        return;
      }
      _status = Status.Unauthenticated;
      notifyListeners();
    });


  }
                                                                                                                               //Borrar string name....surname....email
  Future<void> verifyPhoneNumber(BuildContext context, String number, String name, String surname, String email) async  {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsOTPDialog(context).then((value) {
        print('sing in');

      });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: number.trim(), //Poner el numero para enviar el codigo sms OTP
          codeAutoRetrievalTimeout: (String verId) {
            this.verificationId = verId; //Verificacion del telefono automatica, para enviar codigo sms

          },
          codeSent:
          smsOTPSent,
          timeout: const Duration(seconds: 60),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential.toString() + "lets make this work");
          },

          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message} + something is wrong');
          });
    } catch (e) {
      handleError(e, context);
      errorMessage = e.toString();
      notifyListeners();
    }
  }
  handleError(error, BuildContext context) {
    print(error);
    errorMessage = error.toString();
    notifyListeners();
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        print("la verificacion del codigo no es valida");
        break;
      default:
        errorMessage = error.message;
        break;
    }
    notifyListeners();
  }
                                                                                //sin coma   borrar String name, surname, email
  void _createUser({String id, String number, String name, String surname, String email}) {
    _userServices.createUser({
      "id": id,
      "number": number,
      "name": name,
      "surname": surname,
      "email": email,
    });
  }

  signIn(BuildContext context) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: smsOTP,
      );
      final AuthResult user = await _auth.signInWithCredential(credential);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.user.uid == currentUser.uid);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(LOGGED_IN, true);
      loggedIn = true;
      if (user != null) {
        _userModel = await _userServices.getUserById(user.user.uid);
        if(_userModel == null) {                                                     // number sin coma y borrar strings
          _createUser(id: user.user.uid, number:  user.user.phoneNumber, name: user.user.displayName, surname: user.user.displayName, email: user.user.email);
        }

        loading = false;
        Navigator.of(context).pop();
        changeScreenReplacement(context, Home());
      }
      loading = false;

      Navigator.of(context).pop();
      changeScreenReplacement(context, Home());
      notifyListeners();



    } catch (e) {
      print("${e.toString()}");
    }
  }

  Future<bool> smsOTPDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
                                        //borrar
          return AlertDialog(
            title: Text('Ingresa el codigo SMS '),
            content: Container(
              height: 85,
              child: Column(children: [
                TextField(
                  onChanged: (value) {
                    this.smsOTP = value;
                  },
                ),
              ]),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget> [
              FlatButton(
                child: Text('Enviar'),
                onPressed: () async {
                  loading = true;
                  notifyListeners();
                  _auth.currentUser().then((value) async{
                    if (user != null) {
                      _userModel = await _userServices.getUserById(user.uid);
                      if (_userModel == null) {                                      //sin coma y borrar los strings
                        _createUser(id: user.uid, number: user.phoneNumber, name: user.displayName, surname: user.displayName, email: user.email);
                      }
                      Navigator.of(context).pop();
                      loading = false;
                      notifyListeners();
                      changeScreenReplacement(context, Home());
                    } else {
                      loading = true;
                      notifyListeners();
                      Navigator.of(context).pop();
                      loading = false;
                      signIn(context);
                    }
                  } );
                },

              )
            ],
          );
        });
  }


}