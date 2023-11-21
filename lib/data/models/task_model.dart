class TaskModel {
  int id;
  String title;
  String description;
  String date;
  String status;
  String assignee;

  TaskModel(
      {required this.id,
      required this.assignee,
      required this.date,
      required this.title,
      required this.status,
      required this.description});

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
      id: json["id"],
      title: json["title"],
      assignee: json["assignee"],
      description: json["description"],
      date: json["date"],
      status: json["status"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date,
        "assignee": assignee,
        "status": status
      };
}
