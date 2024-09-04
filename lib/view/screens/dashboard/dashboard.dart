import 'package:task_manager/bloc/task/task_bloc.dart';
import 'package:task_manager/data/provider/language_provider.dart';

import '../../../res/import/import.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key, required this.user});
  final UserModel user;

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> with DatabaseSync {
  @override
  void initState() {
    compareAndSync();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: taskManagerBlack,
      body: Column(
        children: [
          const YMargin(95),
          Row(
            children: [
              const XMargin(21),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: 'https://picsum.photos/200/300',
                      height: 50.sp,
                      width: 50.sp,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const XMargin(8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FlutterI18n.translate(context, 'good_afternoon'),
                        style: TaskManagerTextStyle.size14.copyWith(
                          color: taskManagerWhite,
                        ),
                      ),
                      Text(
                        widget.user.fullName ?? '',
                        style: TaskManagerTextStyle.size20.copyWith(
                          color: taskManagerWhite,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  SvgPicture.asset('message_icon'.mobilesvg),
                  const XMargin(10),
                  GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset('notification_icon'.mobilesvg)),
                ],
              ),
              const XMargin(20),
            ],
          ),
          const Spacer(),
          SizedBox(
            height: 550.sp,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 500.sp,
                    decoration: const BoxDecoration(
                        color: taskManagerSubColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: REdgeInsets.fromLTRB(24, 0, 24, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const YMargin(170),
                            Text(
                              FlutterI18n.translate(context,
                                  'this_is_a_demo_challenge_for_taskManager'),
                              style: TaskManagerTextStyle.size14.copyWith(
                                color: taskManagerColor1,
                              ),
                            ),
                            const YMargin(10),
                            Text(
                              FlutterI18n.translate(context,
                                  'please_select_preferred_language_below'),
                              style: TaskManagerTextStyle.size14.copyWith(
                                color: taskManagerColor1,
                              ),
                            ),
                            const YMargin(10),
                            TextButton(
                                onPressed: () {
                                  lang.setLanguage('en');
                                },
                                child: Text(
                                    FlutterI18n.translate(context, 'english'))),
                            const YMargin(10),
                            TextButton(
                                onPressed: () {
                                  lang.setLanguage('es');
                                },
                                child: Text(
                                    FlutterI18n.translate(context, 'spanish'))),
                            const YMargin(10),
                            TextButton(
                                onPressed: () {
                                  lang.setLanguage('fr');
                                },
                                child: Text(
                                    FlutterI18n.translate(context, 'french'))),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: REdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: const Align(
                    alignment: Alignment.topCenter,
                    child: DashBoardBalanceWidget(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DashBoardBalanceWidget extends StatelessWidget {
  const DashBoardBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: taskManagerColor12,
          width: 1.sp,
        ),
        image: DecorationImage(
            image: AssetImage('wallet_bg'.mobilepng), fit: BoxFit.cover),
      ),
    );
  }
}
