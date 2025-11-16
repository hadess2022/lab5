import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/colculator_screen_cubit.dart';
import 'cubit/colculator_screen_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override

  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorScreenCubit, CalculatorScreenState>(
      builder: (context, state) {
        if (state is CalculatorScreenUpdateState) {
          return getContent(state.dip, state.discretisation, state.long, state.sterio == 1, state, context);
        } 
        return Container();
      },
    );
  }

  Widget getContent(int dip, int discretisation, int long, bool sterio, state, context)
  {
    return Center
    (
    child: Column
      (
        children:
        [
          Text('Введите данные для подсчета'),
          Text("\n\nпри прошлом подсчете использовались параметры:\n "),
          FutureBuilder<String>(
            future: GetFromFile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Загрузка предыдущих параметров...");
              }
              if (snapshot.hasError) {
                return Text("Ошибка загрузки: ${snapshot.error}");
              }
              return Text(snapshot.data!);
            },
          ),


          Form
          (
            child: 
            Container
            (
            padding: EdgeInsets.all(290), 
            child: 
            Column
              (
                children: 
                [
                  Text("Объем звукового файла: ${dip * discretisation * long * (BlocProvider.of<CalculatorScreenCubit>(context).sterio?2:1)}"),

                  Text("частота дискретизации"),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) => 
                    {
                      BlocProvider.of<CalculatorScreenCubit>(context).changeDiscretisation(value == "" ? 0 : int.parse(value))
                    },
                  ),

                  Text("глубина кодирования звука"),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) => 
                    {
                      BlocProvider.of<CalculatorScreenCubit>(context).changeDip(value == "" ? 0 : int.parse(value))
                    },
                  ),

                  Text("длительность звуковой дорожки"),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) => 
                    {
                      BlocProvider.of<CalculatorScreenCubit>(context).changeLong(value == "" ? 0 : int.parse(value))
                    },
                  ),

                  Row(children: 
                    [
                      Text("файл имеет звук в формате стерио"),
                      Checkbox
                      (
                        value: BlocProvider.of<CalculatorScreenCubit>(context).sterio, 
                        onChanged:(value) 
                        { 
                          BlocProvider.of<CalculatorScreenCubit>(context).changeSterio(BlocProvider.of<CalculatorScreenCubit>(context).sterio == false);
                        }
                      )
                    ]
                  ),
                ]
              )
            )
          )
        ]
      )
    );     
  }


  String GetLast()
  {
    String s = GetFromFile().toString();
    return s;
  }

  Future<String> GetFromFile() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int dipr = prefs.getInt("dip") == null ? 0 : prefs.getInt("dip")!;
    int discretisationr = prefs.getInt("discretisation") == null ? 0 : prefs.getInt("discretisation")!;
    int longr = prefs.getInt("long") == null ? 0 : prefs.getInt("long")!;
    bool sterior = prefs.getBool("sterio") == null ? false : prefs.getBool("sterio")!;

    return " частота дискретизации:${discretisationr.toString()}"+
    "\n глубина кодирования звука: ${dipr.toString()}" +
    "\n длительность звуковой дорожки: ${longr.toString()}"+
    "\n наличие стерио: ${(sterior == true ? 'да' : 'нет')}"+
    "\n с результатом: ${dipr * discretisationr * longr * (sterior?2:1)}";
  }
}
