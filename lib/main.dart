import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/landing_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCp1zFJIViCq3mYFiwK3pWjkvX-VBv5Bys", // Your apiKey
      appId: "1:668536051557:web:70a42046ba45540d40338c", // Your appId
      messagingSenderId: "668536051557", // Your messagingSenderId
      projectId: "time-tracker-flutter-cou-83b95", // Your projectId
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            return LandingPage(
              auth: Auth(),
            );
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
