import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rast_mobile_kanban/data/locals/mysharedpref.dart';
import 'package:rast_mobile_kanban/data/models/task_model.dart';
import 'package:rast_mobile_kanban/data/repos/database_repo.dart';
import 'package:rast_mobile_kanban/routes/app_pages.dart';
import 'package:rast_mobile_kanban/ui/blocs/home_page_bloc.dart';

import 'package:rast_mobile_kanban/ui/views/utils/constants.dart';
import 'package:rast_mobile_kanban/ui/views/widgets/bottom_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageBloc bloc = HomePageBloc();
  late Future<List<TaskModel>> data;

  @override
  void initState() {
    super.initState();
    data = DatabaseRepository.instance.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(MySharedPref.getToken().toString());
    List<String> categoryConstants = ["Backlog", "Todo", "inProgress", "Done"];

    List<TaskModel> backlog = [];

    List<TaskModel> todo = [];

    List<TaskModel> inProgress = [];

    List<TaskModel> done = [];

    // main view
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
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
      floatingActionButton: fabButtonBuilder(context),
      body: FutureBuilder(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              for (var element in snapshot.data!) {
                if (element.status == "backlog") {
                  backlog.add(element);
                } else if (element.status == "todo") {
                  todo.add(element);
                } else if (element.status == "inprogress") {
                  inProgress.add(element);
                } else if (element.status == "done") {
                  done.add(element);
                }
              }

              Map<String, List<TaskModel>> categoryList = {
                categoryConstants[0]: backlog,
                categoryConstants[1]: todo,
                categoryConstants[2]: inProgress,
                categoryConstants[3]: done
              };
              return ListView.builder(
                itemCount: categoryList.length,
                itemBuilder: (context, constIndex) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleRowWithDragTargetBuilder(
                        categoryConstants, constIndex, categoryList),
                    draggableCardListBuilder(
                        categoryList, categoryConstants, constIndex)
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text("Data Yüklenirken beklenmeyen bir hata oldu"),
              );
            }
          }),
    );
  }

  FloatingActionButton fabButtonBuilder(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppConstants.primaryColor,
      onPressed: () => bloc.showTodoDialog(context).then((value) async {
        data = DatabaseRepository.instance.getTasks();
      }),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  SizedBox draggableCardListBuilder(Map<String, List<TaskModel>> categoryList,
      List<String> categoryConstants, int constIndex) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          itemCount: categoryList[categoryConstants[constIndex]]!.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, cardIndex) => DraggableCardWidget(
              categoryList: categoryList,
              categoryConstants: categoryConstants,
              constIndex: constIndex,
              cardIndex: cardIndex)),
    );
  }

  DragTarget<Object> titleRowWithDragTargetBuilder(
      List<String> categoryConstants,
      int constIndex,
      Map<String, List<TaskModel>> categoryList) {
    return DragTarget(
      onAccept: (target) async {
        int draggedTaskId = int.parse(target.toString());
        await DatabaseRepository.instance
            .updateStatus(
                draggedTaskId, categoryConstants[constIndex].toLowerCase())
            .then((value) => Get.offAndToNamed(Routes.HOME));
      },
      builder: (context, candidateItems, rejectedItems) => Row(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 32.0, right: 16, bottom: 8, top: 8),
            child: Text(
              categoryConstants[constIndex],
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            categoryList[categoryConstants[constIndex]]!.length.toString(),
            style: const TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class DraggableCardWidget extends StatelessWidget {
  const DraggableCardWidget(
      {super.key,
      required this.categoryList,
      required this.categoryConstants,
      required this.cardIndex,
      required this.constIndex});

  final Map<String, List<TaskModel>> categoryList;
  final List<String> categoryConstants;
  final int constIndex;
  final int cardIndex;

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      data: categoryList[categoryConstants[constIndex]]![cardIndex].id,
      feedback: Container(
        height: 100,
        width: 250,
        decoration: BoxDecoration(
            color: AppConstants.primaryColor,
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            categoryList[categoryConstants[constIndex]]![cardIndex].title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () => Get.toNamed(
          Routes.DESC,
          arguments: categoryList[categoryConstants[constIndex]]![cardIndex],
        ),
        child: SizedBox(
          height: 100,
          width: 350,
          child: Card(
            margin: const EdgeInsets.all(16),
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    categoryList[categoryConstants[constIndex]]![cardIndex]
                        .title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 36,
                    child: Text(
                      categoryList[categoryConstants[constIndex]]![cardIndex]
                          .description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 100,
                        child: StackedAvatar(),
                      ),
                      Text(
                        "6 Feb",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StackedAvatar extends StatelessWidget {
  const StackedAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = RestrictedAmountPositions(
      maxAmountItems: 5,
      maxCoverage: 0.4,
      minCoverage: 0.1,
    );
    return SizedBox(
      height: 50,
      width: 50,
      child: AvatarStack(
        borderWidth: 0,
        settings: settings,
        height: 10,
        width: 10,
        avatars: [
          for (var n = 0; n < 5; n++)
            NetworkImage('https://i.pravatar.cc/150?img=$n')
        ],
      ),
    );
  }
}
