import 'package:task_manager/bloc/task/task_bloc.dart';
import 'package:task_manager/res/enums/enums.dart';
import 'package:task_manager/res/import/import.dart' hide context;
import 'package:task_manager/view/screens/task_screen/widget.dart';
import 'package:uuid/uuid.dart';

class OnlineTasks extends StatefulWidget {
  const OnlineTasks({super.key});

  @override
  State<OnlineTasks> createState() => _OnlineTasksState();
}

class _OnlineTasksState extends State<OnlineTasks> {
  List<TasksModel> tasks = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: taskManagerSubColor,
      body: Padding(
        padding: REdgeInsets.fromLTRB(24, 95, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      FlutterI18n.translate(context, "all_online_tasks"),
                      style: TaskManagerTextStyle.size20.copyWith(
                          fontWeight: FontWeight.w400,
                          color: taskManagerColor2),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.goNamed(
                          RouteNames.addTask,
                          queryParameters: {'isEditEnabled': false.toString()},
                          extra: TasksModel(
                              id: const Uuid().v4(),
                              category: '',
                              title: '',
                              description: '',
                              dueAt: '',
                              reminder: '',
                              createdAt: '',
                              updatedAt: ''),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add,
                            color: taskManagerPrimaryColor,
                          ),
                          Text(
                            FlutterI18n.translate(context, "add_a_task"),
                            style: TaskManagerTextStyle.size14.copyWith(
                                fontWeight: FontWeight.w400,
                                color: taskManagerPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const YMargin(30),
                SizedBox(
                  height: 44.sp,
                  child: CustomTextFormField(
                    hintText: FlutterI18n.translate(context, "search_by_name"),
                    prefixIcon: Padding(
                      padding: REdgeInsets.fromLTRB(23, 0, 5, 0),
                      child: SvgPicture.asset('search'.mobilesvg),
                    ),
                    fillColor: taskManagerColor13,
                    errorBorderColor: taskManagerColor13,
                    focusedBorderColor: taskManagerColor13,
                    enabledBorderColor: taskManagerColor13,
                    borderRadius: 100,
                  ),
                ),
              ],
            ),
            const YMargin(27),
            Expanded(
              child: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoaded) {
                    return ListView.separated(
                        padding: EdgeInsets.zero,
                        itemBuilder: (ctx, index) {
                          final task = state.onlineTasks
                              .where((e) => e.isDeleted == 'false')
                              .toList()[index];
                          return GestureDetector(
                            onTap: () {
                              context.goNamed(
                                RouteNames.addTask,
                                queryParameters: {
                                  'isEditEnabled': true.toString()
                                },
                                extra: TasksModel(
                                  id: task.id,
                                  category: '${task.category}',
                                  title: '${task.title}',
                                  description: '${task.description}',
                                  dueAt: '${task.dueAt}',
                                  reminder: '${task.reminder}',
                                  createdAt: '${task.createdAt}',
                                  updatedAt: '${task.updatedAt}',
                                ),
                              );
                            },
                            child: TaskListWidget(
                              title: '${task.title}',
                              desc: '${task.description}',
                              status: TaskStatus.completed,
                              date: '${task.dueAt}',
                              category: TaskCategory.professional,
                            ),
                          );
                        },
                        separatorBuilder: (ctx, index) => const YMargin(20),
                        itemCount: state.onlineTasks
                            .where((e) => e.isDeleted == 'false')
                            .length);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
