// ignore_for_file: deprecated_member_use

import '../import/import.dart';

class ThemeHelper {
  static ThemeData lightTheme = ThemeData(
    fontFamily: StringConstants.taskManagerFontFamily,
    extensions: [
      taskManagerDesignSystem(
        taskManagerGrey: taskManagerGrey,
        taskManagerBackgroundColor: taskManagerBackgroundColor,
        taskManagerTextColor: taskManagerTextColor,
        containerBg: Colors.white,
      )
    ],
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: taskManagerBackgroundColor,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    // accentColor: Colors.orange,
    canvasColor: Colors.white,
    cardColor: Colors.white,
    dividerColor: Colors.grey,
    focusColor: Colors.blue,
    hoverColor: Colors.grey[200],
    bottomAppBarTheme: const BottomAppBarTheme(
      surfaceTintColor: Colors.white,
    ),
    tabBarTheme: TabBarTheme(
      indicator: const BoxDecoration(
          // color: taskManagerGrey.withOpacity(0.5),
          // borderRadius: BorderRadius.circular(8),
          // boxShadow: const [
          //   BoxShadow(
          //     color: taskManagerGrey,
          //     blurRadius: 2,
          //   ),
          // ],
          ),
      labelPadding: const EdgeInsets.symmetric(vertical: 8),
      indicatorColor: Colors.transparent,
      dividerColor: Colors.transparent,
      labelColor: taskManagerBlack,
      labelStyle: TextStyle(
        fontSize: 14.sp,
        fontStyle: FontStyle.normal,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: taskManagerWhite,
      surfaceTintColor: Colors.white,
      // brightness: Brightness.light,
    ),
    iconTheme: const IconThemeData(
      color: taskManagerBlack,
      size: 24.0,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    extensions: [
      taskManagerDesignSystem(
        taskManagerGrey: taskManagerGrey,
        taskManagerBackgroundColor: taskManagerBackgroundColor,
        taskManagerTextColor: taskManagerTextColor,
        containerBg: taskManagerBackgroundColor,
      )
    ],
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: taskManagerBackgroundColor,

    brightness: Brightness.dark,
    tabBarTheme: const TabBarTheme(
      indicatorColor: Colors.transparent,
      dividerColor: Colors.transparent,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: taskManagerBackgroundColor,
    ),
    primaryColor: Colors.blue,
    // accentColor: Colors.orange,
    canvasColor: Colors.black,
    cardColor: Colors.black,
    dividerColor: Colors.grey,
    focusColor: Colors.blue,
    hoverColor: Colors.grey[200],

    appBarTheme: const AppBarTheme(
      color: taskManagerBackgroundColor,
      // brightness: Brightness.dark,
    ),

    iconTheme: const IconThemeData(
      color: taskManagerWhite,
      size: 24.0,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
    ),
  );
}

class taskManagerDesignSystem extends ThemeExtension<taskManagerDesignSystem> {
  Color? cardStrokeColor;
  Color? taskManagerGrey;
  Color? taskManagerBackgroundColor;
  Color? taskManagerTextColor;
  Color? taskManagerSellColor;
  Color? taskManagerFountainblueColor;
  Color? containerBg;

  taskManagerDesignSystem({
    this.cardStrokeColor,
    this.taskManagerGrey,
    this.taskManagerBackgroundColor,
    this.taskManagerTextColor,
    this.taskManagerSellColor,
    this.taskManagerFountainblueColor,
    this.containerBg,
  });

  @override
  ThemeExtension<taskManagerDesignSystem> copyWith({
    Color? cardStrokeColor,
    Color? taskManagerGrey,
    Color? taskManagerBackgroundColor,
    Color? taskManagerTextColor,
    Color? taskManagerSellColor,
    Color? taskManagerFountainblueColor,
    Color? containerBg,
  }) {
    return taskManagerDesignSystem()
      ..cardStrokeColor = cardStrokeColor ?? this.cardStrokeColor
      ..taskManagerGrey = taskManagerGrey ?? this.taskManagerGrey
      ..taskManagerBackgroundColor =
          taskManagerBackgroundColor ?? this.taskManagerBackgroundColor
      ..taskManagerTextColor = taskManagerTextColor ?? this.taskManagerTextColor
      ..taskManagerTextColor = taskManagerTextColor ?? this.taskManagerTextColor
      ..taskManagerGrey = taskManagerGrey ?? this.taskManagerGrey
      ..taskManagerSellColor = taskManagerSellColor ?? this.taskManagerSellColor
      ..taskManagerGrey = taskManagerGrey ?? this.taskManagerGrey
      ..taskManagerFountainblueColor =
          taskManagerFountainblueColor ?? this.taskManagerFountainblueColor
      ..containerBg = containerBg ?? this.containerBg;
  }

  @override
  ThemeExtension<taskManagerDesignSystem> lerp(
      covariant ThemeExtension<taskManagerDesignSystem>? other, double t) {
    if (other == null) {
      return this;
    }
    final taskManagerDesignSystem otherDesignSystem =
        other as taskManagerDesignSystem;
    return taskManagerDesignSystem(
      cardStrokeColor:
          Color.lerp(cardStrokeColor, otherDesignSystem.cardStrokeColor, t),
      taskManagerGrey:
          Color.lerp(taskManagerGrey, otherDesignSystem.taskManagerGrey, t),
      taskManagerBackgroundColor: Color.lerp(taskManagerBackgroundColor,
          otherDesignSystem.taskManagerBackgroundColor, t),
      taskManagerTextColor: Color.lerp(
          taskManagerTextColor, otherDesignSystem.taskManagerTextColor, t),
      taskManagerSellColor: Color.lerp(
          taskManagerSellColor, otherDesignSystem.taskManagerSellColor, t),
      taskManagerFountainblueColor: Color.lerp(taskManagerFountainblueColor,
          otherDesignSystem.taskManagerFountainblueColor, t),
      containerBg: Color.lerp(containerBg, otherDesignSystem.containerBg, t),
    );
  }
}

extension ThemeDataExtension on BuildContext {
  taskManagerDesignSystem? get designSystem =>
      Theme.of(this).extension<taskManagerDesignSystem>();
}
