import '../import/import.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

class RouteGenerator {
  RouteGenerator._();

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/${RouteNames.signup}',
    errorBuilder: (context, state) => const CustomError(
      errorDetails: null,
    ),
    // redirect: (BuildContext context, GoRouterState state) async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   final provider = context.read<AuthenticationProvider>();
    //   final isAuthenticated =
    //       await provider.getUser(token: prefs.getString('token') ?? '');
    //   if (isAuthenticated == false) {
    //     return '/${RouteNames.login}';
    //   } else {
    //     return null;
    //   }
    // },
    routes: <RouteBase>[
      GoRoute(
        name: RouteNames.splash,
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: RouteNames.signup,
        path: '/${RouteNames.signup}',
        builder: (context, state) => const CreateAccountScreen(),
        routes: <RouteBase>[
         
        ],
      ),
      GoRoute(
        name: RouteNames.login,
        path: '/${RouteNames.login}',
        builder: (context, state) => const WelcomeBackScreen(),
      ),
      GoRoute(
        name: RouteNames.forgetPassword,
        path: '/${RouteNames.forgetPassword}',
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _sectionNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                name: RouteNames.dashboard,
                path: '/dashboard',
                builder: (context, state) => DashBoardScreen(
                  user: state.extra as UserModel,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                name: RouteNames.onlineTask,
                path: '/${RouteNames.onlineTask}',
                builder: (context, state) => const OnlineTasks(),
                routes: [
                  GoRoute(
                      name: RouteNames.addTask,
                      path: RouteNames.addTask,
                      builder: (context, state) {
                        return AddTaskScreen(
                          isEditEnabled: bool.tryParse(state
                                  .uri.queryParameters['isEditEnabled']!) ??
                              false,
                          tasks: state.extra as TasksModel?,
                        );
                      }),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                name: RouteNames.offlineTask,
                path: '/${RouteNames.offlineTask}',
                builder: (context, state) => const Offlinetasks(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
