import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/catalog_screen_cubit.dart';
import 'Catalog_screen.dart';

class CatalogScreenProvider extends StatelessWidget {
  const CatalogScreenProvider({super.key});

  @override
  Widget build (BuildContext context) {
    return BlocProvider<CatalogScreenCubit>( 
      create: (context) => CatalogScreenCubit(),
      child: CatalogScreen(),
    );
  }
}