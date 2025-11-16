import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/history_screen_cubit.dart';
import 'cubit/history_screen_state.dart';
import 'data_base_worker.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});


  @override

  Widget build(BuildContext context) 
  {
    return BlocBuilder<HistoryScreenCubit, HistoryScreenState>(
      builder: (context, state) {
        if (state is HistoryScreenUpdateState) {
          return getContent(state.dip, state.discretisation, state.long, state.sterio == 1, state, context);
        } 
        return Container();
      },
    );
  }


  Widget getContent(int dip, int discretisation, int long, bool sterio, state, context)
  {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DBProvider.db.getFromBD("*", "order by id desc"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Нет данных'));
        }
        
        List<Map<String, dynamic>> rez = snapshot.data!;
        List<String> discretisation = rez.map((item) => item['discretisation'].toString()).toList();
        List<String> dip = rez.map((item) => item['dip'].toString()).toList();
        List<String> long = rez.map((item) => item['long'].toString()).toList();
        List<String> sterio = rez.map((item) => item['sterio'].toString()).toList();
        List<String> rezalt = rez.map((item) => item['rezalt'].toString()).toList();
        
        return Center
        (
          child: Column
          (
            children: 
            [
              Text('История запросов \n\n'),
              Row
                (
                  children: 
                  [
                    SizedBox(width: 300),
                    Column
                    (
                      children: 
                      [
                        Text("частота дискретизации"),
                        for(int i = 0; i < discretisation.length; i++)
                          Text(discretisation[i])
                      ]
                    ),
                    SizedBox(width: 40),
                    Column
                    (
                      children: 
                      [
                        Text("глубина кодирования звука"),
                        for(int i = 0; i < dip.length; i++)
                          Text(dip[i])
                      ]
                    ),
                    SizedBox(width: 40),
                    Column
                    (
                      children: 
                      [
                        Text("длительность звуковой дорожки"),
                        for(int i = 0; i < long.length; i++)
                          Text(long[i])
                      ]
                    ),
                    SizedBox(width: 40),
                    Column
                    (
                      children: 
                      [
                        Text("наличие стерио"),
                        for(int i = 0; i < sterio.length; i++)
                          Text(sterio[i])
                      ]
                    ),
                    SizedBox(width: 40),
                    Column
                    (
                      children: 
                      [
                        Text("результат"),
                        for(int i = 0; i < rezalt.length; i++)
                          Text(rezalt[i])
                      ]
                    )
                  ]
                )
            ]
          )
        );     
      },
    );
  }
}
