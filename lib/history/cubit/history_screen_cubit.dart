import 'history_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreenCubit extends Cubit<HistoryScreenState>{
  HistoryScreenCubit(): super(HistoryScreenUpdateState(sterio: false, discretisation: 0, dip: 0, long: 0));

  bool sterio = false;
  int discretisation = 0;
  int dip = 0;
  int long = 0; 

  void changeSterio(bool st){
    sterio = st;
    emit(HistoryScreenUpdateState(sterio: sterio, discretisation: discretisation, dip: dip, long: long));
  }

  void changeDiscretisation(int st){
    discretisation = st;
    emit(HistoryScreenUpdateState(sterio: sterio, discretisation: discretisation, dip: dip, long: long));
  }

  void changeDip(int st){
    dip = st;
    emit(HistoryScreenUpdateState(sterio: sterio, discretisation: discretisation, dip: dip, long: long));
  }

  void changeLong(int st){
    long = st;
    emit(HistoryScreenUpdateState(sterio: sterio, discretisation: discretisation, dip: dip, long: long));
  }
}