abstract class AppStates{}

class AppInitialState extends AppStates{}


class BottomNavBarChangeScreenState extends AppStates {}

class AppErrorState implements AppStates {
  final String message;
  AppErrorState(this.message);
}
