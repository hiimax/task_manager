import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/res/enums/enums.dart';
import 'package:task_manager/res/import/import.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    required this.title,
    required this.desc,
    required this.status,
    required this.date,
    required this.category,
    this.onPressed,
  });

  final String title, desc, date;
  final TaskCategory category;
  final TaskStatus status;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: taskManagerColor12,
            width: 1.sp,
          ),
        ),
        child: Padding(
          padding: REdgeInsets.fromLTRB(9, 14, 9, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'house_property'.mobilepng,
                    width: 33.sp,
                    height: 33.sp,
                  ),
                  const XMargin(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TaskManagerTextStyle.size14.copyWith(
                            color: taskManagerColor2,
                            fontWeight: FontWeight.w400),
                      ),
                      const YMargin(2),
                      Text(
                        desc,
                        style: TaskManagerTextStyle.size12.copyWith(
                            color: taskManagerColor14,
                            fontWeight: FontWeight.w400),
                      ),
                      const YMargin(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: taskManagerColor14.withOpacity(0.1),
                                border: Border.all(
                                  color: taskManagerColor15,
                                  width: 0.5.sp,
                                )),
                            child: Padding(
                              padding: REdgeInsets.fromLTRB(8, 1.5, 8, 1.5),
                              child: Text(
                                status.name,
                                style: TaskManagerTextStyle.size12.copyWith(
                                  color: taskManagerColor11,
                                ),
                              ),
                            ),
                          ),
                          const XMargin(10),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: taskManagerColor14.withOpacity(0.1),
                                border: Border.all(
                                  color: taskManagerColor15,
                                  width: 0.5.sp,
                                )),
                            child: Padding(
                              padding: REdgeInsets.fromLTRB(8, 1.5, 8, 1.5),
                              child: Text(
                                category.name,
                                style: TaskManagerTextStyle.size12.copyWith(
                                  color: taskManagerColor11,
                                ),
                              ),
                            ),
                          ),
                          const XMargin(10),
                          Text(
                            date.dateFormat(),
                            style: TaskManagerTextStyle.size10.copyWith(
                                color: taskManagerColor2,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              SvgPicture.asset(
                'arrow_forward'.mobilesvg,
                height: 12.sp,
                width: 12.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarSheet extends StatelessWidget {
  CalendarSheet(
      {super.key, this.values = const [], required this.dateController});
  List<DateTime?> values;
  TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        width: double.infinity,
        height: 600.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.sp),
              topRight: Radius.circular(20.sp)),
          color: taskManagerSubColor,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.fromLTRB(24, 22, 24, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      child: SvgPicture.asset(
                        'assets/svg/arrow_back.svg',
                      ),
                    ),
                  ],
                ),
                const YMargin(18),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FlutterI18n.translate(
                                context, "pick_due_date"),
                            style: TaskManagerTextStyle.size20
                                .copyWith(color: taskManagerColor2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const YMargin(20),
                Container(
                  height: 340.sp,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.sp),
                    border: Border.all(
                      color: taskManagerColor4,
                      width: 1.sp,
                    ),
                  ),
                  child: Padding(
                    padding: REdgeInsets.all(15),
                    child: CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                          centerAlignModePicker: true,
                          firstDayOfWeek: 1,
                          calendarType: CalendarDatePicker2Type.single,
                          selectedDayTextStyle: TaskManagerTextStyle.size16
                              .copyWith(color: taskManagerWhite),
                          selectedDayHighlightColor: taskManagerPrimaryColor,
                          customModePickerIcon: const SizedBox(),
                        ),
                        value: values,
                        onValueChanged: (dates) {
                          values = dates;
                          dateController.text =
                              DateFormat('dd-MM-yyyy').format(values[0]!);
                        }),
                  ),
                ),
                const YMargin(29),
                CustomButton(
                  title: FlutterI18n.translate(context, "continue_to"),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
