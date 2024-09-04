import 'package:task_manager/bloc/task/task_bloc.dart';
import 'package:task_manager/res/enums/enums.dart';
import 'package:task_manager/res/import/import.dart';
import 'package:task_manager/view/screens/task_screen/widget.dart';

class Offlinetasks extends StatefulWidget {
  const Offlinetasks({super.key});

  @override
  State<Offlinetasks> createState() => _OfflinetasksState();
}

class _OfflinetasksState extends State<Offlinetasks> with DatabaseSync {
  bool syncing = false;

  void syncDatabase() async {
    toggleSync(value: true);
    print('syncing');
    await compareAndSync();
    print('done syncing');
    toggleSync(value: false);
  }

  void toggleSync({required bool value}) {
    setState(() {
      syncing = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is TaskLoaded) {
          toggleSync(value: false);
        }
      },
      child: Scaffold(
        backgroundColor: taskManagerSubColor,
        body: Padding(
          padding: REdgeInsets.fromLTRB(24, 77, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    FlutterI18n.translate(context, "all_offline_tasks"),
                    style: TaskManagerTextStyle.size20.copyWith(
                        fontWeight: FontWeight.w400, color: taskManagerColor2),
                  ),
                  const Spacer(),
                  BlocBuilder<TaskBloc, TaskState>(
                    builder: (context, state) {
                      if (state is TaskLoaded) {
                        return TextButton.icon(
                          onPressed: syncDatabase,
                          icon: syncing
                              ? null
                              : const Icon(
                                  Icons.sync_outlined,
                                  color: taskManagerPrimaryColor,
                                ),
                          iconAlignment: IconAlignment.end,
                          label: syncing
                              ? const CircularProgressIndicator.adaptive()
                              : Text(
                                  'Sync(${state.offlineTasks.length})'
                                      .replaceAll('(0)', ''),
                                  style: TaskManagerTextStyle.size14.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: taskManagerPrimaryColor),
                                ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
              const YMargin(48),
              Expanded(
                child: BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state is TaskLoaded) {
                      final tasks = [
                        ...state.offlineTasks,
                        ...state.onlineTasks
                      ]
                          .where((element) => element.isDeleted == 'false')
                          .toList();
                      return ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (ctx, index) {
                            return TaskListWidget(
                              title: '${tasks[index].title}',
                              desc: '${tasks[index].description}',
                              status: TaskStatus.completed,
                              date: '${tasks[index].dueAt}',
                              category: TaskCategory.professional,
                            );
                          },
                          separatorBuilder: (ctx, index) => const YMargin(20),
                          itemCount: tasks.length);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
