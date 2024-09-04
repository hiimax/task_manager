import 'package:form_validator/form_validator.dart';
import 'package:task_manager/bloc/task/task_bloc.dart';
import 'package:task_manager/res/enums/enums.dart';
import 'package:task_manager/res/import/import.dart' hide context;
import 'package:task_manager/view/screens/task_screen/widget.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, required this.isEditEnabled, this.tasks});
  final bool isEditEnabled;
  final TasksModel? tasks;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  final List<DateTime?> _dates = [
    DateTime.now(),
  ];
  late final TaskBloc _taskBloc;

  @override
  void initState() {
    _taskBloc = context.read<TaskBloc>();
    if (widget.isEditEnabled) {
      nameController.text = widget.tasks!.title ?? '';
      categoryController.text = widget.tasks!.category ?? '';
      descriptionController.text = widget.tasks!.description ?? '';
      dateController.text = widget.tasks!.dueAt ?? '';
      timeController.text = widget.tasks!.reminder ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    descriptionController.dispose();
    timeController.dispose();
    dateController.dispose();
    super.dispose();
  }

  void addTask() {
    if (_formKey.currentState!.validate()) {
      final task = TasksModel(
        id: const Uuid().v4(),
        title: nameController.text,
        description: descriptionController.text,
        category: categoryController.text,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        dueAt: DateTime.now().toIso8601String(),
        reminder: timeController.text,
        isDeleted: 'false',
        isSynced: 'false',
      );

      _taskBloc.add(CreateEvent(tasksModel: task));
    }
  }

  void updateTask() {
    if (_formKey.currentState!.validate()) {
      final task = TasksModel(
        id: const Uuid().v4(),
        title: nameController.text,
        description: descriptionController.text,
        category: categoryController.text,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        dueAt: DateTime.now().toIso8601String(),
        reminder: DateTime.now().toIso8601String(),
        isDeleted: 'false',
        isSynced: 'false',
      );

      _taskBloc.add(UpdateEvent(tasksModel: task));
    }
  }

  void deleteTask() {
    final task = TasksModel(
      id: const Uuid().v4(),
      title: nameController.text,
      description: descriptionController.text,
      category: categoryController.text,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
      dueAt: DateTime.now().toIso8601String(),
      reminder: DateTime.now().toIso8601String(),
      isDeleted: 'true',
      isSynced: 'false',
    );

    _taskBloc.add(DeleteEvent(tasksModel: task));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskError) {
            showErrorToast(message: state.message, context: context);
          }
          if (state is TaskSuccess) {
            showSuccessToast(
                message:
                    FlutterI18n.translate(context, "task_created_successfully"),
                context: context);
            context.pop();
          }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: REdgeInsets.fromLTRB(24, 95, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: context.pop,
                            child: SvgPicture.asset(
                              'arrow_back'.mobilesvg,
                            ),
                          ),
                          const Spacer(),
                          if (widget.isEditEnabled)
                            BlocBuilder<TaskBloc, TaskState>(
                              builder: (context, state) {
                                if (state is TaskLoading) {
                                  return const CircularProgressIndicator
                                      .adaptive();
                                }
                                return GestureDetector(
                                  onTap: deleteTask,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.delete,
                                        color: taskManagerRed,
                                      ),
                                      Text(
                                        FlutterI18n.translate(
                                            context, "delete_task"),
                                        style: TaskManagerTextStyle.size14
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: taskManagerRed),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                      const YMargin(22),
                      Text(
                        FlutterI18n.translate(
                            context,
                            widget.isEditEnabled
                                ? "edit_task"
                                : "add_new_task"),
                        style: TaskManagerTextStyle.size24.copyWith(
                          color: taskManagerColor2,
                        ),
                      ),
                    ],
                  ),
                  const YMargin(24),
                  inputFieldTitle(
                    FlutterI18n.translate(context, "task_name"),
                  ),
                  CustomTextFormField(
                    hintText:
                        FlutterI18n.translate(context, "enter_tasks_name"),
                    fillColor: taskManagerWhite,
                    enabledBorderColor: taskManagerColor8,
                    errorBorderColor: taskManagerColor8,
                    focusedBorderColor: taskManagerColor8,
                    controller: nameController,
                    validator: ValidationBuilder().required().build(),
                  ),
                  const YMargin(20),
                  inputFieldTitle(
                    FlutterI18n.translate(context, "task_description"),
                  ),
                  CustomTextFormField(
                    hintText: FlutterI18n.translate(
                        context, "enter_tasks_description"),
                    fillColor: taskManagerWhite,
                    enabledBorderColor: taskManagerColor8,
                    errorBorderColor: taskManagerColor8,
                    focusedBorderColor: taskManagerColor8,
                    controller: descriptionController,
                    validator: ValidationBuilder().required().build(),
                    maxLines: 3,
                  ),
                  const YMargin(20),
                  inputFieldTitle(
                    FlutterI18n.translate(context, "task_category"),
                  ),
                  CustomTextFormFieldDropDown(
                    width: MediaQuery.of(context).size.width,
                    hintText:
                        FlutterI18n.translate(context, "select_tasks_category"),
                    fillColor: taskManagerWhite,
                    enabledBorderColor: taskManagerColor8,
                    errorBorderColor: taskManagerColor8,
                    focusedBorderColor: taskManagerColor8,
                    items: TaskCategory.values.map((e) => e.name).toList(),
                    validator: ValidationBuilder().required().build(),
                    onchanged: (val) {
                      categoryController.text = val ?? '';

                      setState(() {});
                    },
                  ),
                  const YMargin(20),
                  Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            inputFieldTitle(
                              FlutterI18n.translate(context, "task_due_date"),
                            ),
                            Builder(builder: (ctx) {
                              return CustomTextFormField(
                                hintText: FlutterI18n.translate(
                                    context, "enter_due_date"),
                                fillColor: taskManagerWhite,
                                enabledBorderColor: taskManagerColor8,
                                errorBorderColor: taskManagerColor8,
                                focusedBorderColor: taskManagerColor8,
                                readonly: true,
                                onTap: () {
                                  Scaffold.of(ctx).showBottomSheet(
                                    (ctx) {
                                      return CalendarSheet(
                                        values: _dates,
                                        dateController: dateController,
                                      );
                                    },
                                  );
                                },
                                controller: dateController,
                                validator:
                                    ValidationBuilder().required().build(),
                              );
                            }),
                          ],
                        ),
                      ),
                      const XMargin(20),
                      Expanded(
                        flex: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            inputFieldTitle(
                              FlutterI18n.translate(
                                  context, "task_reminder_time"),
                            ),
                            CustomTextFormFieldDropDown(
                              width: MediaQuery.of(context).size.width,
                              hintText: FlutterI18n.translate(
                                  context, "reminder_time"),
                              fillColor: taskManagerWhite,
                              enabledBorderColor: taskManagerColor8,
                              errorBorderColor: taskManagerColor8,
                              focusedBorderColor: taskManagerColor8,
                              items: const [
                                '10 mins',
                                '15 mins',
                                '20 mins',
                                '25 mins',
                                '30 mins',
                              ],
                              validator: ValidationBuilder().required().build(),
                              onchanged: (val) {
                                timeController.text = val ?? '';

                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const YMargin(20),
                  const YMargin(20),
                  CustomButton2(
                    title: FlutterI18n.translate(context,
                        widget.isEditEnabled ? "update_task" : 'add_task'),
                    buttonColor: taskManagerBlack,
                    borderColor: taskManagerBlack,
                    onPressed: widget.isEditEnabled ? updateTask : addTask,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
