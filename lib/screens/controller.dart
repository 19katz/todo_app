import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../model.dart';

// GetxController controls the state of the UI of the app. We create a controller
// class by extending GetxController. This will interact with the UI of the todo
// app such that it rebuilds when there is a change in state with the notes.
class NoteController extends GetxController {
  // We make this variable observable so that other parts of the interface will
  // respond to changes in the notes/tasks
  var notes = < Note >[].obs;

  // adds a new note to the list of notes
  void add(Note n) {
    notes.add(n);
  }

  // When initialized, the controller should use GetStorage, which is a package
  // that stores app data in memory, read in the list of notes/tasks to memory.
  @override
  void onInit() {
    // use GetStorage to read in the tasks from storage
    List? storedNotes = GetStorage().read < List > ('notes');
    if (!storedNotes.isNull) {
      // if there are tasks in the list, then create notes from the json
      // and load them into the notes variable
      notes = storedNotes!.map((e) => Note.fromJson(e)).toList().obs;
    }
    ever(notes, (_) {
      // write the notes to storage in a key-value pair.
      GetStorage().write('notes', notes.toList());
    });
    super.onInit();
  }
}