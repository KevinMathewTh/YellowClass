import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:my_movie_list/adapters/movie_adapter.dart';
import 'package:my_movie_list/views/add_movie.dart';
import 'dart:io';

import 'package:my_movie_list/views/edit_movie.dart';
import 'package:path/path.dart';

class MovieView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddMovie()));
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title:
            Text("My Movie List", style: TextStyle(fontFamily: "Montserrat")),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Movie>('movies').listenable(),
        builder: (context, Box<Movie> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Text(
                "No data available",
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            );
          }
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                Movie? movie = box.getAt(index);
                return Card(
                    child: Padding(
                        padding: EdgeInsets.all(1.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit
                                          .contain, // otherwise the logo will be tiny
                                      child: new Image.file(
                                        File(() {
                                          if (movie?.img != null) {
                                            return movie!.img;
                                          } else {
                                            return "lib/views/default.jpg";
                                          }
                                        }()),
                                        height: 30.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Text(movie!.title,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 22)),
                                      Text(movie.director,
                                          textAlign: TextAlign.center),
                                      Container(
                                        width: 80,
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: IconButton(
                                                    onPressed: () async {
                                                      await box.deleteAt(index);
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red[400],
                                                    ))),
                                            Expanded(
                                                child: IconButton(
                                                    onPressed: () => Navigator
                                                            .of(context)
                                                        .push(MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    EditMovie(
                                                                      formkey:
                                                                          index,
                                                                    ))),
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: Colors.green[400],
                                                    )))
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            ])));
              });
        },
      ),
    );
  }
}

updateLogs(int idx) async {
  Box<Movie> movieBox = Hive.box<Movie>('movies');
  movieBox.putAt(
      idx,
      Movie(
          title: "hello",
          director: "test",
          img: fromUri("lib/views/default.jpg")));
}
