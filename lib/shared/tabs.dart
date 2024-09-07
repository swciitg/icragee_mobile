import 'package:icragee_mobile/shared/icons.dart';

enum HomeTabs{
  home,
  schedule,
  map,
  food,
}

extension HomeTabsExtension on HomeTabs{
  String get name{
    switch(this){
      case HomeTabs.home:
        return 'Home';
      case HomeTabs.schedule:
        return 'Schedule';
      case HomeTabs.map:
        return 'Map';
      case HomeTabs.food:
        return 'Food';
    }
  }

  String get unselectedIconPath{
    switch (this) {
      case HomeTabs.home:
        return MyIcons.homeUnselected;
      case HomeTabs.schedule:
        return MyIcons.scheduleUnselected;
      case HomeTabs.map:
        return MyIcons.mapUnselected;
      case HomeTabs.food:
        return MyIcons.foodUnselected;
    }
  }

  String get selectedIconPath{
    switch (this) {
      case HomeTabs.home:
        return MyIcons.homeSelected;
      case HomeTabs.schedule:
        return MyIcons.scheduleSelected;
      case HomeTabs.map:
        return MyIcons.mapSelected;
      case HomeTabs.food:
        return MyIcons.foodSelected;
    }
  }

}