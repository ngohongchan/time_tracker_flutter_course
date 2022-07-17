import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/add_job_page.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_exeption_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/database.dart';

class JobsPage extends StatelessWidget {
  // HomePage({Key? key, required this.auth}) : super(key: key);
  // final AuthBase auth;

  Future<void> _signOut(BuildContext context) async {
    final auth = Provider.of<AuthBase>(
      context,
      listen: false,
    );
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    );

    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Future<void> _createJob(context) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.createJob(Job(
        name: 'Blogging',
        ratePerHour: 10,
      ));
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => AddJobPage.show(context),
      ),
      body: _buildContents(context),
    );
  }

  Widget _buildContents(context) {
    final database = Provider.of<Database>(context, listen: false);

    return StreamBuilder<List<Job?>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        print(snapshot.hasData);
        if (snapshot.hasData) {
          final jobs = snapshot.data;
          final children = jobs?.map((e) => Text(e!.name)).toList();
          print(jobs?.map((e) => Text(e!.name)).toList());
          return ListView(
            children: children!,
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Some error occurred'),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
