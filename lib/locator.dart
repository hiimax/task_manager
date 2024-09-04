import 'package:provider/single_child_widget.dart';
import 'package:task_manager/bloc/task/task_bloc.dart';
import 'package:task_manager/data/provider/language_provider.dart';
import 'package:task_manager/res/import/import.dart';

// final locationProvider = ChangeNotifierProvider((ref) => LocationProvider());
// final authenticationProvider =
//     ChangeNotifierProvider((ref) => AuthenticationProvider());
// final propertyManagementProvider =
//     ChangeNotifierProvider((ref) => PropertyManagementProvider());

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  BlocProvider<AuthenticationBloc>(create: (_) => AuthenticationBloc()),
  BlocProvider<TaskBloc>(create: (_) => TaskBloc()..add(FetchTasks())),
  ChangeNotifierProvider(create: (_) => LanguageProvider()),
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [];

List<SingleChildWidget> dependentServices = [];

List<SingleChildWidget> uiConsumableProviders = [];
