import 'package:hive/hive.dart';
import 'dart:io';
part 'movie_adapter.g.dart';

@HiveType(typeId: 1)
class Movie extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String director;
  @HiveField(2)
  String img;

  Movie({required this.title, required this.director, required this.img});
}
