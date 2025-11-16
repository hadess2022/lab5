import 'package:flutter/material.dart';
import 'main_screen_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() async
{
  //dart run sqflite_common_ffi_web:setup
  //dart run sqflite_common_ffi_web:setup --force
  databaseFactory = databaseFactoryFfiWeb;
  runApp(MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return MainScreenProvider();
  }
}

