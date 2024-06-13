import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? id;
  String? title;
  String? description;
  String? dateTime;
  bool? priority;
  String? type;
  bool? status;

  TodoModel(
      {this.id,
      this.title,
      this.description,
      this.dateTime,
      this.priority,
      this.type,
      this.status});

  TodoModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["dateTime"] is String) {
      dateTime = json["dateTime"];
    }
    if (json["priority"] is bool) {
      priority = json["priority"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
  }

  factory TodoModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data();
    return TodoModel(
        id: data["id"],
        dateTime: data["dateTime"],
        description: data["description"],
        priority: data["priority"],
        title: data["title"],
        type: data["type"],
        status: data["status"]);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["description"] = description;
    data["dateTime"] = dateTime;
    data["priority"] = priority;
    data["type"] = type;
    data["status"] = status;
    return data;
  }
}
