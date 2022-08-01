// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:time_tracker_flutter_course/app/home/models/job.dart';
// import 'package:time_tracker_flutter_course/common_widgets/show_alert_dialog.dart';
// import 'package:time_tracker_flutter_course/common_widgets/show_exeption_alert_dialog.dart';
// import 'package:time_tracker_flutter_course/services/database.dart';

// class AddJobPage extends StatefulWidget {
//   const AddJobPage({Key? key, required this.database}) : super(key: key);

//   final Database database;

//   static Future<void> show(BuildContext context) async {
//     final database = Provider.of<Database>(context, listen: false);
//     await Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => AddJobPage(
//           database: database,
//         ),
//         fullscreenDialog: true,
//       ),
//     );
//   }

//   @override
//   _AddJobPageState createState() => _AddJobPageState();
// }

// class _AddJobPageState extends State<AddJobPage> {
//   final _formKey = GlobalKey<FormState>();

//   late String _name;
//   late int _ratePerHour;

//   bool _validateAndSaveForm() {
//     final form = _formKey.currentState;
//     if (form!.validate()) {
//       form.save();
//       return true;
//     }
//     return false;
//   }

//   void _submit() async {
//     if (_validateAndSaveForm()) {
//       try {
//         final jobs = await widget.database.jobsStream().first;
//         final allNames = jobs.map((job) => job!.name).toList();

//         if (allNames.contains(_name)) {
//           showAlertDialog(
//             context,
//             title: 'Name aldready used',
//             content: 'Please choose a different job name',
//             defaultActionText: 'OK',
//           );
//         } else {
//           final job = Job(name: _name, ratePerHour: _ratePerHour);
//           await widget.database.setJob(job);
//           Navigator.of(context).pop();
//         }
//       } on FirebaseException catch (e) {
//         showExceptionAlertDialog(
//           context,
//           title: 'Operation failed',
//           exception: e,
//         );
//       }
//     } else {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 2.0,
//         title: Text('New Job'),
//         actions: [
//           FlatButton(
//             onPressed: _submit,
//             child: Text(
//               'save',
//               style: TextStyle(fontSize: 18, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//       body: _buildContents(context),
//     );
//   }

//   Widget _buildContents(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Card(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: _buildForm(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildForm() {
//     return Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: _buildFormChildren(),
//         ));
//   }

//   List<Widget> _buildFormChildren() {
//     return [
//       TextFormField(
//         decoration: InputDecoration(labelText: 'Job name'),
//         onSaved: (value) => _name = value!,
//         validator: (value) => value!.isNotEmpty ? null : 'Name can\'t be empty',
//       ),
//       TextFormField(
//         decoration: InputDecoration(labelText: 'Rate per hour'),
//         keyboardType: TextInputType.numberWithOptions(
//           signed: false,
//           decimal: false,
//         ),
//         onChanged: (value) => _ratePerHour = int.tryParse(value)!,
//       ),
//     ];
//   }
// }
