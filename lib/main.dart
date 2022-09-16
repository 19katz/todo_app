import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/screens/notes_list.dart';

// This main Dart file is what runs our actual app itself. Dart is a language
// used to code Flutter apps. In this file, we write a main method, which
// we use to run our app.
// We then define a class for our todo app, which is rendered using runApp
// in the main function.
void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

// We let the app itself be a stateless widget, as the state of the app itself
// never changes -- there is no need to incorporate multiple states.
// We also use the MaterialApp class, which extends the basic WidgetsApp by
// adding various styles.
class MyApp extends StatelessWidget {
  @override
  // This method is called when the widget (the app, in this case) is built
  // in the widget tree, a structure that holds widgets in Flutter.
  Widget build(BuildContext context) {
    // Creates a Material app (as described above) and specifies some styles
    // and themes
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // The home property of the app widget describes the widget
      // that the app is routed to when the homepage is reached.
      // In this case, we use the NoteList widget, which is defined
      // in our "screens" subfolder.
      home: NoteList(),
    );
  }
}
