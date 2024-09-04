import '../../../res/import/import.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      callApi();
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> callApi() async {
    _loading.value = true;
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        _loading.value = false;
      });
    });
    // if (!loading) {
    //   context.goNamed(RouteNames.onBoarding);

    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: _loading,
          builder: (context, loading, _) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: taskManagerSplashColor,
              child: Center(
                child: Image.asset(
                  'image 1'.mobilepng,
                  scale: 2.sp,
                ),
              ),
            );
          }),
    );
  }
}
