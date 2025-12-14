import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/catalog_screen_cubit.dart';
import 'cubit/catalog_screen_state.dart';
import 'category.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogScreenCubit, CatalogScreenState>(
      builder: (context, state) {
        if (state is CatalogScreenUpdateState) 
        {
          if(state.films.isEmpty)
          {
            BlocProvider.of<CatalogScreenCubit>(context).updateCategory(state.category);
          }
          return getContent(context, state.category, state.films, state.posters); 
        } 
        return Container();
      },
    );
  }

  Widget getContent(BuildContext context, String category, Map<String, dynamic> films, List<String> posters) {

    return Center(
      child: Column(
        children: [
          DropdownButton(
            value: category,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: categorys.keys.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                BlocProvider.of<CatalogScreenCubit>(context).updateCategory(newValue);
              }
            },
          ),
          
          if(films.isNotEmpty) 
          ...[
            for (int i=0;i<20;i++) 
            ...[
              Text(films["items"][i].toString()),
              Text(""),
              Padding(padding: EdgeInsets.all(10)),
              GetFilmBlock(films["items"][i], posters[i]),
              Text(""),
            ]
          ]
        ],
      ),
    );
  }

  Widget GetFilmBlock(dynamic film, String poster)
  {
    return Container
    (
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color.fromARGB(255, 61, 61, 61)),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

      child: Row
      (
        children: 
        [
          Padding(padding: EdgeInsets.all(10)),

          Image.network(
            poster,
            width: 100,
            height: 150,
            fit: BoxFit.cover
          ),
          
          Padding(padding: EdgeInsets.all(10)),

          if(film["nameRu"].toString() != "null")
          ...[
            Text(film["nameRu"].toString())
          ]
          else if(film["name"].toString() != "null")
          ...[
            Text(film["name"].toString())
          ]
          else
          ...[
            Text(film["nameOriginal"].toString())
          ]
        ],
      ),
    );
  } 
}