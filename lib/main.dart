import 'package:flutter_doroti/providers/auth.dart';
import 'package:flutter_doroti/pantallas/HomeScreen.dart';
import 'package:flutter_doroti/pantallas/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doroti/pantallas/splash.dart';
import 'package:provider/provider.dart';




void main()  {
  WidgetsFlutterBinding.ensureInitialized();

  runApp (MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AuthProvider.initialize())
  ],
    child: MyApp(),));  //MultiProvider


}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doroti',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.

        ),
        home: ScreensController()
    );
  }
}

class ScreensController extends StatelessWidget {

  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    if (auth.status == Status.Uninitialized){
      return Splash();

    }else{
      if (auth.loggedIn) {
        return Home();

      }else {
        return Login();
      }
    }

  }
}