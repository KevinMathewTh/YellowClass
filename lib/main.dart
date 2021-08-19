import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_movie_list/adapters/movie_adapter.dart';
import 'views/MovieView.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  await Hive.close();
  await Hive.openBox<Movie>('movies');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.dark(), home: MovieView());
  }
}
