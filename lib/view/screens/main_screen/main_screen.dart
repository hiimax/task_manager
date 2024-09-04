import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import '../../../../res/import/import.dart';
import '../../../utils/Widgets/bottom_navigation.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
    required this.navigationShell,
  }) : super(key: key);
  final StatefulNavigationShell navigationShell;
  void onPageChanged(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          body: navigationShell,
          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
              height: 100.sp,
              itemCount: 3,
              tabBuilder: (int index, bool isActive) {
                return BottomNavWidgets(
                  color: isActive
                      ? taskManagerPrimaryColor
                      : taskManagerCountryColor,
                  index: index,
                );
              },
              activeIndex: navigationShell.currentIndex,
              gapWidth: 0,
              onTap: onPageChanged),
        ));
  }
}
