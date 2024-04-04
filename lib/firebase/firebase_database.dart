import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/utils.dart' as u;
import 'package:todo_app/globals.dart' as g;

class FirebaseDatabase {
  FirebaseFirestore database = FirebaseFirestore.instance;

  Future<List<TodoModel>> readData(
      String searchFromRange, String searchToRange) async {
    QuerySnapshot<Map<String, dynamic>> collectionReference = await database
        .collection(g.userMail)
        .where(
          FieldPath.documentId,
          isGreaterThanOrEqualTo: searchFromRange,
        )
        .where(FieldPath.documentId, isLessThan: searchToRange)
        .get();

    return collectionReference.docs
        .map((e) => TodoModel.fromSnapshot(e))
        .toList();
  }

  void storeData(String collecID, TodoModel data, String docId,
      {Function(String fail)? onErrror,
      Function(String data)? onSuccess}) async {
    await database
        .collection(collecID)
        .doc(docId)
        .set(data.toJson())
        .whenComplete(() {
      onSuccess!("Successfully added your task!.");
    }).catchError((error, sta) {
      onErrror!("Could not add task. Try again later.");
    });
  }

  Future updateData(
    TodoModel data,
  ) async {
    await database
        .collection(g.userMail)
        .doc(data.id)
        .set(data.toJson())
        .whenComplete(() {
      return null;
    }).catchError((error, sta) {
      u.showWarning("Error", "Something went wrong. Try again later.");
      return error;
    });
  }

  storeCollaborator(Map<String, dynamic> data, String collaboratorEmail,
      {Function()? onSuccess, Function(dynamic)? onError}) async {
    await database
        .collection("collaborators")
        .doc(g.userMail)
        .set(data)
        .whenComplete(() {
      onSuccess!();
    }).catchError((error, _) {
      u.showWarning("Error", "Something went wrong. Try again later.");
      onError!(error);
    });
  }

  getAllCollaborators(
      {Function(DocumentSnapshot data)? onSuccess,
      Function(dynamic err)? onError}) {
    database.collection("collaborators").doc(g.userMail).get().then((val) {
      print(val);
      onSuccess!(val);
    }).catchError((err, _) {
      onError!(err);
    });
  }
}
