import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/main_screen_cubit.dart';
import 'cubit/main_screen_state.dart';
import 'colculator/colculator_screen_provider.dart';
import 'history/history_screen_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});


  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              BlocBuilder<MainScreenCubit, MainScreenState>(
                builder: (context, state) {
                  if (state is MainScreenUpdateState) {
                    return getContent(context, state.historical == false);
                  } 
                  return Container();
                },
              )
            ]
          )
        )
      )
    );
  }

  Widget getContent(context, bool historical){
    return Center(
      child: Column(
        children:
        [
          TextButton(onPressed: (){BlocProvider.of<MainScreenCubit>(context).GoToHistory();}, child: Text(!historical? "перейти к подсчетам" : "перейти в историю")),
          GetScrin(historical)
        ]
      )
    );     
  }

  StatelessWidget GetScrin(bool historical)
  {
    if(!historical)
    {
      return HistoryScreenProvider();
    }
    else
    {
      return CalculatorScreenProvider();
    }
  }
}
