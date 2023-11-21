import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rast_mobile_kanban/data/locals/mysharedpref.dart';
import 'package:rast_mobile_kanban/data/models/task_model.dart';
import 'package:rast_mobile_kanban/data/repos/database_repo.dart';
import 'package:rast_mobile_kanban/ui/views/utils/constants.dart';

class HomePageBloc {
  RxBool isDrag = false.obs;

  RxInt indexOfDragItem = 0.obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController assigneeController = TextEditingController();

  Future<void> clearTextEditors() async {
    titleController.text = "";
    descriptionController.text = "";
    statusController.text = "";
    assigneeController.text = "";
  }

  Future saveTask() async {
    var saveTask = TaskModel(
        id: MySharedPref.getTaskId(),
        assignee: assigneeController.text,
        date: "6 feb",
        title: titleController.text,
        status: statusController.text,
        description: descriptionController.text);

    DatabaseRepository.instance.insertTask(saveTask);
  }

  isMoving() {
    if (isDrag.value == false) {
      isDrag.value = true;
    }
  }

  isDropped() {
    if (isDrag.value == true) {
      isDrag.value = false;
    }
  }

  Future<dynamic> showTodoDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black12,
      context: context,
      builder: (context) => AlertDialog(
        shadowColor: Colors.black,
        scrollable: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        iconPadding: EdgeInsets.zero,
        icon: Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () async {
                await clearTextEditors();
                Get.back();
              },
              icon: const Icon(Icons.close)),
        ),
        title: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "ToDo",
              style: Theme.of(context).textTheme.titleMedium,
            )),
        titlePadding: const EdgeInsets.only(left: 16),
        content: SizedBox(
          height: 450,
          width: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: titleController,
                  decoration: todoInputDecoration("Title"),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(decoration: TextDecoration.none),
                ),
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: descriptionController,
                  decoration: todoInputDecoration("Description"),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(decoration: TextDecoration.none),
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  controller: statusController,
                  decoration: todoInputDecoration("Status"),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(decoration: TextDecoration.none),
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: assigneeController,
                  decoration: todoInputDecoration("Assignee"),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(decoration: TextDecoration.none),
                ),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            height: 60,
            width: 120,
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  backgroundColor: const MaterialStatePropertyAll(
                      AppConstants.primaryColor)),
              onPressed: () async {
                await saveTask();
                await clearTextEditors();
                await MySharedPref.setTaskId(MySharedPref.getTaskId());
                Get.back();
              },
              child: Text(
                "Save",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

InputDecoration todoInputDecoration(
  String labelText, {
  IconData? iconData,
  String? prefix,
  String? helperText,
}) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    helperText: helperText,
    labelText: labelText,
    prefixStyle: const TextStyle(color: Colors.white, fontSize: 14),
    suffixStyle: const TextStyle(color: Colors.white, fontSize: 14),
    hintStyle: const TextStyle(color: Colors.white, fontSize: 14),
    labelStyle: const TextStyle(color: Colors.white, fontSize: 14),
    fillColor: Colors.transparent,
    filled: true,
    // prefixText: prefix,

    prefixIconConstraints: const BoxConstraints(minWidth: 60),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      // borderSide: BorderSide(color: Colors.grey),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      // borderSide: BorderSide(color: Colors.grey),
    ),
  );
}
