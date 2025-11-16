import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/colculator_screen_cubit.dart';
import 'colculator_screen.dart';

class CalculatorScreenProvider extends StatelessWidget {
  const CalculatorScreenProvider({super.key});

  @override
  Widget build (BuildContext context) {
    return BlocProvider<CalculatorScreenCubit>( 
      create: (context) => CalculatorScreenCubit(),
      child: CalculatorScreen(),
    );
  }
}