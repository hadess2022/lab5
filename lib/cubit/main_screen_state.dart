abstract class MainScreenState{}

class MainScreenUpdateState extends MainScreenState{
  final bool historical;

  MainScreenUpdateState({required this.historical});
}