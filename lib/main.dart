import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/landing_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAiqlNg5VlHJJ80JHUFbgYUkAbdVkzWWt0", // Your apiKey
      appId: "1:89886561511:web:d28319f15424b27f843e42", // Your appId
      messagingSenderId: "89886561511", // Your messagingSenderId
      projectId: "time-tracker-project-3d391", // Your projectId
    ),
  );

  // if (kIsWeb) {
  //   // initialiaze the facebook javascript SDK
  //   await FacebookAuth.instance.webInitialize(
  //     appId: "587222272563409",
  //     cookie: true,
  //     xfbml: true,
  //     version: "v14.0",
  //   );
  // }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Time Tracker',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("Error");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return LandingPage();
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
