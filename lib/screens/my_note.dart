import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model.dart';
import 'controller.dart';

// This code describes a singular note/task widget when either entering
// or editing a new note. This page will be rendered when we either create
// or edit a note.
class MyNote extends StatelessWidget {
  // index of the note to be retrieved
  int index =0 ;

  MyNote({Key? key, required this.index}) : super(key: key);

  // Code for building the note creation widget.
  @override
  Widget build(BuildContext context) {
    // create a new NoteController, which controls the UI state
    final NoteController nc = Get.find();
    // get text from the task using the NoteController
    String text = "";
    // if index = 0, the note/task is being created, so there is no text yet
    if (index == 0) {
      text = " ";
    } else {
      // otherwise, it should be set to the text from the preexisting note/task
      text = nc.notes[index].title;
    }
    // A TextEditingController helps to control the appearance of text
    // when it has been changed. This is helpful here because this page
    // involves editing or creating the text for a new note.
    TextEditingController textEditingController =
        new TextEditingController(text: text);
    return SafeArea(
        child: Scaffold(
          // This app bar is the bar that appears at the top of the screen.
          // The bar displays text based on the status of the page (whether
          // it is in edit mode or add mode).
            appBar: AppBar(
              // if the index is 0, then this means that there is no preexisting
              // task and we are creating a new task. Otherwise, we must be
              // editing a task.
              title: index == 0
                  ? Text('Add a new task')
                  : Text('Edit task'),
            ),
            body: Padding(
              // Formatting for the body of the app.
              padding: EdgeInsets.all(15),
              child: Container(
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // This
                  children: <Widget>[
                    Expanded(
                      // This text field is used for adding a new task.
                      child: TextField(
                        // use textEditingController to control the appearance
                        // of the UI in response to changes in text
                        controller: textEditingController,
                        autofocus: true,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          // text shown at the top of the page
                          hintText: 'Add a new task',
                          labelText: 'Enter',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black87),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        style: TextStyle(fontSize: 20),
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                      ),
                    ),
                    // The Row widget displays data in a horizontally oriented
                    // fashion.
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // Creates a back button for each
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('Back'),

                          ),
                          // Button which, when pressed, either updates the task
                          // (if it is being edited) or adds it to the list of
                          // notes/tasks (if it is being added anew)
                          ElevatedButton(
                            onPressed: () {
                              // index = 0 indicates that the task did not exist
                              // previously and is thus being added.
                              if (index == 0) {
                                nc.notes.add(
                                    Note(title: textEditingController.text));
                              } else {
                                // otherwise, we find the task from the list of
                                // notes/tasks provided by the controller
                                // and then update the title and the list of
                                // notes/tasks.
                                var updatenote = nc.notes[index];
                                updatenote.title = textEditingController.text;
                                nc.notes[index] = updatenote;
                              }
                              Get.back();
                            },
                            // if index = 0, this means that we are adding
                            // a new task (the task is not numbered yet)
                            // Thus, the text displayed on the button will be
                            // 'Add'. Otherwise, this means that we are editing
                            // task 'index,' so the tesk will say 'update.'
                            // This is due to the usage of MyNote to display
                            // both adding and editing tasks.
                            child: index == 0 ? Text('Add') : Text('Update'),
                          )
                        ])
                  ],
                ),
              ),
            )));
  }
}
