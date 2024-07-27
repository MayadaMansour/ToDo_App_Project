class Task {
  static const String collectionName = "tasks";
  String id;
  String title;
  String description;
  bool isDone;
  DateTime dateTime;

  Task(
      {this.id = "",
      required this.title,
      required this.description,
      this.isDone = false,
      required this.dateTime});

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "isDone": isDone,
      "dateTime": dateTime.millisecondsSinceEpoch
    };
  }

  Task.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data["id"],
            title: data["title"],
            description: data["description"],
            isDone: data["isDone"],
            dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]));
}
