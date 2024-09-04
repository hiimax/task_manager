import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_manager/data/provider/language_provider.dart';
import 'package:task_manager/firebase_options.dart';
import 'package:task_manager/res/view_route/route_generator.dart';

import '../../res/import/import.dart';

final navigatorKey = GlobalKey<NavigatorState>();
var logger = Logger();

class CustomBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    debugPrint('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('$bloc $error $stackTrace');
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    debugPrint('$transition');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('$event');
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    debugPrint('$bloc');
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    debugPrint('$bloc');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instanceFor(app: app);
  Bloc.observer = CustomBlocObserver();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MultiBlocProvider(
        providers: providers,
        child: Consumer<LanguageProvider>(builder: (context, lang, _) {
          return GlobalLoaderOverlay(
              useDefaultLoading: false,
              overlayWidgetBuilder: (_) {
                return const Center(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          taskManagerPrimaryColor),
                    ),
                  ),
                );
              },
              child: MaterialApp.router(
                  builder: (BuildContext context, Widget? widget) {
                    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                      return CustomError(errorDetails: errorDetails);
                    };
                    return widget!;
                  },
                  localizationsDelegates: [
                    FlutterI18nDelegate(
                      translationLoader: FileTranslationLoader(),
                      missingTranslationHandler: (key, locale) {},
                    ),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  localeResolutionCallback: (deviceLocale, supportedLocales) {
                    for (var locale in supportedLocales) {
                      if (locale.languageCode == deviceLocale!.languageCode) {
                        return deviceLocale;
                      }
                    }
                    return supportedLocales.first;
                  },
                  supportedLocales: const [
                    Locale('en'),
                    Locale('es'),
                    Locale('fr'),
                  ],
                  locale: Locale(lang.language),
                  debugShowCheckedModeBanner: false,
                  title: StringConstants.appName,
                  theme: ThemeHelper.lightTheme,
                  routerConfig: RouteGenerator.router));
        }),
      ),
    );
  }
}
