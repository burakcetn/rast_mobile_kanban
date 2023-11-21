import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rast_mobile_kanban/routes/app_pages.dart';

class KanbanAppBottomNavbar extends StatelessWidget {
  const KanbanAppBottomNavbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 3, blurRadius: 5)
        ],
      ),
      child: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(Icons.home_outlined),
            onPressed: () {
              Get.offAllNamed(Routes.HOME);
            },
          ),
        ),
      ),
    );
  }
}
