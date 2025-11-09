import 'package:flutter/material.dart';
import 'package:flutter_vai_ou_racha/telas/home_tela.dart';
import 'package:flutter_vai_ou_racha/telas/lista_cliente_tela.dart';
import 'package:flutter_vai_ou_racha/database/database_helper.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
    print('Usando SQLite FFI Web');
  } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    print('Usando SQLite FFI (Desktop)');
  } else {
    print('Usando SQLite nativo (Mobile)');
  }

  await DatabaseHelper.instance.database;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vai ou Racha',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: HomeTela(),
      debugShowCheckedModeBanner: false,
    );
  }
}
