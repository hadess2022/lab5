import 'main_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenCubit extends Cubit<MainScreenState>{
  MainScreenCubit(): super(MainScreenUpdateState(historical: false));

  bool historical = false;

  // ignore: non_constant_identifier_names
  void GoToHistory()
  {
    historical = !historical;
    emit(MainScreenUpdateState(historical: historical));
  }
}