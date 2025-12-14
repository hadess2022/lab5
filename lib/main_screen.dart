import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/main_screen_cubit.dart';
import 'cubit/main_screen_state.dart';
import 'catalog/catalog_screen_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Widget getContent(context, bool historical){
    return Center(
      child: Column(
        children:
        [
          getScrin(historical)
        ]
      )
    );     
  }

  StatelessWidget getScrin(bool historical)
  {
    return CatalogScreenProvider();
  }
}