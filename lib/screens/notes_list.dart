import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/my_note.dart';
import 'my_note.dart';
import 'controller.dart';

// This class is also a stateless widget that is displayed when the main app
// is directed to the home screen. It represents the actual list of items
// in the todo app.
class NoteList extends StatelessWidget {
  // Once again, we specify how the widget should be built. Specifically,
  // we specify how the todo list should be displayed when there are/are not
  // elements.
  @override
  Widget build(BuildContext context) {
    // Creates a NoteController for updating note data on the UI
    final NoteController nc = Get.put(NoteController());
    Widget getNoteList() {
      return Obx(
        () => nc.notes.length == 0
        // If there are no notes, then just display the default "lists" image
            ? Center(
                child: Image.asset('assets/lists.jpeg'),
              )
        // Otherwise, build the list and display it.
            : ListView.builder(
                itemCount: nc.notes.length,
                itemBuilder: (context, index) => Card(
                      child: ListTile(
                          title: Text(nc.notes[index].title,
                              style: TextStyle(fontWeight: FontWeight.w500)),
                          leading: Text(
                            (index + 1).toString() + ".",
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing: Wrap(children: <Widget>[
                            // Button for creating a new task (+ sign on the home interface)
                            IconButton(
                                icon: Icon(Icons.create),
                                // When pressed, this should take us to the MyNote page,
                                // which is for creating a new note/task.
                                onPressed: () => Get.to(MyNote(index: index))),
                            // Button for deleting a task.
                            IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  // Create a dialog window for confirming
                                  // or denying the deletion of a task
                                  Get.defaultDialog(
                                      // Displays the dialog and show that it is for deleting
                                      title: 'Delete Task',
                                      // Use the NoteController to get the title of the note
                                      // being deleted
                                      middleText: nc.notes[index].title,
                                      // if cancelled, use Get to return back
                                      // to the previous page
                                      onCancel: () => Get.back(),
                                      confirmTextColor: Colors.white,
                                      // if confirmed, then remove the note
                                      // from the list of notes using index
                                      onConfirm: () {
                                        nc.notes.removeAt(index);
                                        Get.back();
                                      });
                                })
                          ])),
                    )),
      );
    }

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Todo App'),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Get.to(MyNote(index: 0,));
              },
            ),
            body: Container(
              child: Padding(padding: EdgeInsets.all(5), child: getNoteList()),
            )));
  }
}
