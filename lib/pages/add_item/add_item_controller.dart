// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:todo_app/components/add_collaborator_popup.dart';
import 'package:todo_app/firebase/firebase_database.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/pages/todo_list/todo_list_controller.dart';
import 'package:todo_app/utils.dart' as u;
import 'package:todo_app/globals.dart' as g;
import '../../constant.dart';

class AddItemController extends GetxController {
  TimeOfDay? startTime;
  TextEditingController sTimeStr = TextEditingController();
  TimeOfDay? endTime;
  TextEditingController eTimeStr = TextEditingController();
  var selectedDate = DateTime.now().obs;
  var goingToMakePriority = false.obs;
  var focus = FocusNode().obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController collbName = TextEditingController();
  TextEditingController collabMail = TextEditingController();

  storeCollaboratorsTask(TodoModel todo, String uniqueId, String usersMail) {
    FirebaseDatabase().storeData(
      usersMail,
      todo,
      uniqueId,
      onSuccess: (data) {},
      onErrror: (fail) {},
    );
  }

  validateInputs() {
    if (titleController.text.isEmpty) {
      u.showWarning("Warning", "Please give title of the task");
    } else if (descriptionController.text.isEmpty) {
      u.showWarning("Warning", "Please give the description");
    } else {
      createTask();
    }
  }

  createTask() {
    storeDataToDb();
  }

  storeDataToDb() async {
    print("inside function");
    u.showLoading("creating");
    TodoModel todoData = TodoModel.fromJson({});

    String uniqueId = u.getUniqueId(selectedDate.value);
    todoData.type = "todo";
    todoData.title = titleController.text;
    todoData.description = descriptionController.text;
    todoData.dateTime = selectedDate.value.toString();
    todoData.priority = goingToMakePriority.value;
    todoData.id = uniqueId;
    todoData.status = false;
    print("going....");
    for (int i = 0; i < selectedCollabIds.length; i++) {
      storeCollaboratorsTask(todoData, uniqueId, selectedCollabIds[i]);
    }
    print("gonna call storeData");
    FirebaseDatabase().storeData(
      g.userMail,
      todoData,
      uniqueId,
      onSuccess: (data) {
        print("inside onsuccess");
        clearData();
        clearCollabDetails();
        Get.find<TodoListController>().searchByToday();
        Get.find<TodoListController>().getTodos();
        u.closeLoading();
        u.showWarning("", data);
      },
      onErrror: (fail) {
        print("on error");
        u.closeLoading();
        u.showWarning("", fail);
      },
    );
  }

  createNewCollaborators() {
    showAddCollaboratorPopup(() {
      if (collbName.text.isEmpty || collabMail.text.isEmpty) {
        u.showWarning(
            "Invalid", "Please give name as well as email of collborator");
      } else if (g.userMail == collabMail.text) {
        u.showWarning("Invalid",
            "You cannot add yourself as collaborator. Make sure given email is not yours.");
      } else if (checkCollabIsAlreadyAddedOrNot()) {
        u.showWarning("", "This email already added as your collborator");
      } else {
        Get.back();
        storeCollabUser();
      }
    });
  }

  clearData() {
    makeAllUnSelected();
    selectedCollabIds = [];
    selectedCollabNames.value = [];
    goingToMakePriority.value = false;
    selectedDate.value = DateTime.now();
    titleController.clear();
    sTimeStr.text = "";
    eTimeStr.text = "";
    startTime = null;
    endTime = null;
    descriptionController.clear();
  }

  sendEmail() async {
    try {
      SmtpServer smtpServer =
          gmail("taskcollaborative@gmail.com", "mjaz spug moui fcnf");
      Message message = Message();
      message.from = const Address("taskcollaborative@gmail.com");
      // collab.789
      message.recipients.add(collabMail);
      message.text = "this is test message";
      SendReport report = await send(message, smtpServer);

      clearCollabDetails();
    } on Exception catch (_) {
      u.showWarning("Oops", "Could not send email");
    }
  }

  storeCollabUser() {
    u.showLoading("Adding...");

    Map<String, String> collabData = {
      "name": collbName.text,
      "email": collabMail.text
    };
    FirebaseDatabase().storeCollaborator(
      g.makeCollabPayloadGetRead(collabData),
      collabData["email"]!,
      onSuccess: () {
        u.closeLoading();
        u.showWarning("Great!..",
            "Successfully added ${collbName.text} as your collaborator");
        clearCollabDetails();
      },
      onError: (p0) {
        u.closeLoading();
        u.showWarning("Failure", "Could not add collaborator");
      },
    );
  }

  clearCollabDetails() {
    collbName.text = "";
    collabMail.text = "";
  }

  checkCollabIsAlreadyAddedOrNot() {
    for (Map element in g.collabUsers) {
      if (element["email"] == collabMail.text) {
        return true;
      }
    }
    return false;
  }

  getDropdownMenuItems() {
    List<DropdownMenuItem<String>> menus = [];
    for (Map element in g.collabUsers) {
      menus.add(DropdownMenuItem(
          value: element["email"],
          child: u.PoppinsText(
            text: element["name"],
          )));
    }
    return menus;
  }

  var selectedCollabBool = [].obs;
  List<String> selectedCollabIds = [];
  var selectedCollabNames = <String>[].obs;

  makeAllUnSelected() {
    for (int i = 0; i < g.collabUsers.length; i++) {
      selectedCollabBool.insert(i, false);
    }
    update();
  }

  selectCollab(int index, bool value, String id) {
    selectedCollabBool[index] = value;
    if (value) {
      selectedCollabIds.add(id);
    } else {
      selectedCollabIds.remove(id);
    }
    getAllCollabNames();
    update();
  }

  getAllCollabNames() {
    selectedCollabNames.value = [];
    for (int i = 0; i < g.collabUsers.length; i++) {
      for (int j = 0; j < selectedCollabIds.length; j++) {
        if (g.collabUsers[i]["email"] == selectedCollabIds[j]) {
          selectedCollabNames.add(g.collabUsers[i]["name"]);
        }
      }
    }
    update();
  }

  showAddCollabaratorToTask() {
    Get.defaultDialog(
        title: "Collaborators",
        content: Column(
          children: [
            for (int i = 0; i < g.collabUsers.length; i++)
              GetBuilder<AddItemController>(builder: (cont) {
                return Row(
                  children: [
                    Checkbox(
                      value: selectedCollabBool[i],
                      onChanged: (bool? value) {
                        selectCollab(i, value!, g.collabUsers[i]["email"]);
                      },
                    ),
                    u.PoppinsText(
                      text: g.collabUsers[i]["name"],
                    )
                  ],
                );
              }),
          ],
        ),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: violet),
              onPressed: () {
                Get.back();
              },
              child: const u.PoppinsText(
                text: "Okay",
              ))
        ]);
  }

  bool showDetails() {
    if (titleController.text.isNotEmpty) {
      return true;
    }
    return false;
  }
}
