import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/job_entries/job_entries_page.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/edit_job_page.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/job_list_title.dart';
import 'package:time_tracker_flutter_course/app/home/jobs/list_items_builder.dart';
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

  Future<void> _delete(context, job) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteJob(job);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  // Future<void> _createJob(context) async {
  //   try {
  //     final database = Provider.of<Database>(context, listen: false);
  //     await database.setJob(Job(
  //       name: 'Blogging',
  //       ratePerHour: 10,
  //     ));
  //   } on FirebaseException catch (e) {
  //     showExceptionAlertDialog(
  //       context,
  //       title: 'Operation failed',
  //       exception: e,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: <Widget>[
          IconButton(
            onPressed: () => EditJobPage.show(context,
                database: Provider.of<Database>(context, listen: false)),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
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
      body: _buildContents(context),
    );
  }

  Widget _buildContents(context) {
    final database = Provider.of<Database>(context, listen: false);

    return StreamBuilder<List<Job?>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder(
          snapshot: snapshot,
          itemBuilder: (context, job) => Dismissible(
            key: Key('job-${job}'),
            direction: DismissDirection.endToStart,
            background: Container(color: Colors.red),
            onDismissed: (direction) => _delete(context, job),
            child: JobListTitle(
              job: job as Job,
              onTap: () => JobEntriesPage.show(context, job),
            ),
          ),
        );

        // print(snapshot.hasData);
        // if (snapshot.hasData) {
        //   final jobs = snapshot.data;

        //   if (jobs!.isNotEmpty) {
        //     final children = jobs
        //         .map((e) => JobListTitle(
        //             job: e!, onTap: () => EditJobPage.show(context, job: e)))
        //         .toList();
        //     print(jobs.map((e) => Text(e!.name)).toList());
        //     return ListView(
        //       children: children,
        //     );
        //   }

        //   return EmptyContent();
        // }

        // if (snapshot.hasError) {
        //   return Center(
        //     child: Text('Some error occurred'),
        //   );
        // }

        // return Center(
        //   child: CircularProgressIndicator(),
        // );
      },
    );
  }
}
