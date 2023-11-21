import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:rast_mobile_kanban/data/locals/mysharedpref.dart';
import 'package:rast_mobile_kanban/data/models/task_model.dart';
import 'package:rast_mobile_kanban/data/repos/database_repo.dart';
import 'package:rast_mobile_kanban/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MySharedPref.init();

  await DatabaseRepository.instance.db;

  MySharedPref.setTaskId(3);

  // for creating default database

  var task1 = TaskModel(
      id: 0,
      assignee: "assignee",
      date: "6 feb",
      title: "Implement Clean Architecture in Flutter Application",
      status: "backlog",
      description:
          "The objective of this task is to refactor our existing Flutter application to adhere to Clean Architecture principles.");
  var task2 = TaskModel(
      id: 1,
      assignee: "assignee",
      date: "date",
      title: "todo - Implement Layered Application Architecture",
      status: "todo",
      description:
          "The objective of this task is to refactor our existing Flutter application to adhere to Clean Architecture principles.");
  var task3 = TaskModel(
      id: 2,
      assignee: "assignee",
      date: "date",
      title: "Inprogress - Implement Layered Application Architecture",
      status: "inprogress",
      description:
          "The objective of this task is to refactor our existing Flutter application to adhere to Clean Architecture principles.");
  var task4 = TaskModel(
      id: 3,
      assignee: "assignee",
      date: "date",
      title: "Done - Implement Layered Application Architecture",
      status: "done",
      description:
          "The objective of this task is to refactor our existing Flutter application to adhere to Clean Architecture principles.");

  List<TaskModel> defaultList = [task1, task2, task3, task4];

  for (var elements in defaultList) {
    DatabaseRepository.instance.insertTask(elements);
  }

  runApp(
    ScreenUtilInit(
      designSize: const Size(1080, 2400),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Rast Mobile Kanban App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          themeMode: ThemeMode.light,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    ),
  );
}
