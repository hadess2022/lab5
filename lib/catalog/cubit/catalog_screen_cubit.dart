import 'catalog_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../category.dart';

class CatalogScreenCubit extends Cubit<CatalogScreenState> {
  CatalogScreenCubit() : super(CatalogScreenUpdateState(category: "все", films: {}, posters: List.empty()));

  static const String _apiKey = '8c8e1a50-6322-4135-8875-5d40a5420d86';
  
  final Map<String, String> _headers = {
    'X-API-KEY': _apiKey,
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };


  void updateCategory(String newValue) async 
  {
    Map<String, dynamic> films = await getFilmsAsync(categorys[newValue]!);
    List<String> posters = [];

    if(films.isNotEmpty)
    {
      for (int i = 0; i < 20; i++) 
      {
        try 
        {
          Map<String, dynamic> poster = await getFilmPoster(films["items"][i]["kinopoiskId"].toString());
          
          // Проверяем, есть ли постеры
          if (poster.containsKey("items") && 
              poster["items"] is List && 
              poster["items"].length > 0 &&
              poster["items"][0].containsKey("imageUrl")) 
          {
            posters.add(poster["items"][0]["imageUrl"].toString());
          } 
          else 
          {
            posters.add("https://avatars.mds.yandex.net/i?id=bf80cfff6fdc84bc6e5dc04b467cf64f6b10c277-6605286-images-thumbs&n=13");
          }
        } catch (e) 
        {
          posters.add("https://avatars.mds.yandex.net/i?id=bf80cfff6fdc84bc6e5dc04b467cf64f6b10c277-6605286-images-thumbs&n=13");
        }
      }
      
      // Если нужно 20 постеров, добавляем заглушки для недостающих
      if (posters.length < 20) {
        for (int i = posters.length; i < 20; i++) {
          posters.add("https://avatars.mds.yandex.net/i?id=bf80cfff6fdc84bc6e5dc04b467cf64f6b10c277-6605286-images-thumbs&n=13");
        }
      }
    }
    else
    {
      for (int i=0;i<20;i++) 
      {
        posters.add("https://avatars.mds.yandex.net/i?id=bf80cfff6fdc84bc6e5dc04b467cf64f6b10c277-6605286-images-thumbs&n=13");
      }
    }
    
    emit(CatalogScreenUpdateState(category: newValue, films: films, posters: posters));
  }

  Future<Map<String, dynamic>> getFilmPoster(String id) async {
    String url = "https://kinopoiskapiunofficial.tech/api/v2.2/films/$id/images?type=POSTER&page=1";
    final response = await http.get(
      Uri.parse(url),
      headers: _headers,
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load film: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getFilmsAsync(int category) async {
    String url = "https://kinopoiskapiunofficial.tech/api/v2.2/films?${category!=0?"genres=$category&":""}type=ALL&ratingFrom=0&yearFrom=2007&page=1";
    final response = await http.get(
      Uri.parse(url),
      headers: _headers,
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load film: ${response.statusCode}');
    }
  }
}