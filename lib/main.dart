import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Импорт Firebase Core
import 'package:kino_2/glavscreen/movie_list_screen.dart'; // Импорт экрана со списком фильмов

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Инициализация Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кино список',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieListScreen(), // Экран со списком фильмов
    );
  }
}