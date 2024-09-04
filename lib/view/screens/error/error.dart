import 'package:task_manager/res/import/import.dart';

class CustomError extends StatelessWidget {
  final FlutterErrorDetails? errorDetails;

  const CustomError({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const FlutterLogo(size: 100),
              const YMargin(30),

              Text(
                'Oopse! ',
                textAlign: TextAlign.center,
                style: TaskManagerTextStyle.size20.copyWith(
                  color: taskManagerPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const YMargin(10),
              Text(
                ' Something went wrong!',
                textAlign: TextAlign.center,
                style: TaskManagerTextStyle.size20.copyWith(
                  color: taskManagerPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const YMargin(10),
              Text(
                kDebugMode
                    ? '${errorDetails?.summary ?? 'Oups! Something went wrong!'}'
                    : 'Oups! Something went wrong!',
                textAlign: TextAlign.center,
                style: TaskManagerTextStyle.size20.copyWith(
                  color: kDebugMode ? taskManagerRed : taskManagerBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const YMargin(12),
              // const Text(
              //   kDebugMode
              //       ? 'https://docs.flutter.dev/testing/errors'
              //       : "We encountered an error and we've notified our engineering team about it. Sorry for the inconvenience caused.",
              //   textAlign: TextAlign.center,
              //   style: TaskManagerTextStyle.small.copyWith(color: Colors.black, fontSize: 14),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
