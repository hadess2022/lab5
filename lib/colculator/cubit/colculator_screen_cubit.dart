import 'colculator_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../history/data_base_worker.dart';

class CalculatorScreenCubit extends Cubit<CalculatorScreenState>{
  CalculatorScreenCubit(): super(CalculatorScreenUpdateState(sterio: false, discretisation: 0, dip: 0, long: 0));

  bool sterio = false;
  int discretisation = 0;
  int dip = 0;
  int long = 0; 

  void changeSterio(bool st)
  {
    sterio = st;
    save();
    emit(CalculatorScreenUpdateState(sterio: sterio, discretisation: discretisation, dip: dip, long: long));
  }

  void changeDiscretisation(int st) 
  {
    discretisation = st;
    save();
    emit(CalculatorScreenUpdateState(sterio: sterio, discretisation: discretisation, dip: dip, long: long));
  }

  void changeDip(int st)
  {
    dip = st;
    save();
    emit(CalculatorScreenUpdateState(sterio: sterio, discretisation: discretisation, dip: dip, long: long));
  }

  void changeLong(int st)
  {
    long = st;
    save();
    emit(CalculatorScreenUpdateState(sterio: sterio, discretisation: discretisation, dip: dip, long: long));
  }

  void save() async
  {
    if(discretisation!=0  && dip != 0 && long != 0)
    {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt("discretisation", discretisation);
      await prefs.setBool("sterio", sterio);
      await prefs.setInt("dip", dip);
      await prefs.setInt("long", long);
      
      
      await DBProvider.db.setToBD(long, discretisation, dip, sterio, dip * discretisation * long * (sterio?2:1));
    }

  }
}