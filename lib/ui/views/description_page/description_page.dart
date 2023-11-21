import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rast_mobile_kanban/data/models/task_model.dart';
import 'package:rast_mobile_kanban/data/repos/database_repo.dart';
import 'package:rast_mobile_kanban/routes/app_pages.dart';
import 'package:rast_mobile_kanban/ui/views/utils/constants.dart';
import 'package:rast_mobile_kanban/ui/views/widgets/bottom_navbar.dart';

class DescriptionPage extends StatelessWidget {
  const DescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    TaskModel taskModel = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        title: Image.asset(
          "assets/images/logo.png",
          height: 30,
          color: Colors.white,
        ),
        actions: const [
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const KanbanAppBottomNavbar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            taskModel.title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
              ),
              const SizedBox(
                width: 16,
              ),
              const Text("Reported by "),
              Text(
                "Project Manager",
                style: Theme.of(context).textTheme.titleSmall,
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  taskModel.status,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
              Text(taskModel.date),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Description",
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.grey),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(taskModel.description),
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
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
                  await DatabaseRepository.instance.deleteTask(taskModel.id);
                  Get.offAllNamed(Routes.HOME);
                },
                child: Text(
                  "Delete",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
