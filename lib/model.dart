// Much like in the Node.js/MongoDB app, we have a model (like the TodoTask
// we made before) for a Note (or task). Unlike in the MongoDB application,
// this Note is simply a class to structure data for the todo list.
// Each Note contains a title (the text in the note).
class Note {
  String title;

  Note({required this.title});

  // The following methods are used to store and retrieve structured data
  // when communicating with the web server.
  // fromJson creates a Note object from a map that just contains the attributes
  // of the Note in json format.
  // toJson creates a Map containing attributes from the Note in json format.
  factory Note.fromJson(Map<String, dynamic> json) =>
      Note(title: json['title']);

  Map<String, dynamic> toJson() => {'title': title};
}
