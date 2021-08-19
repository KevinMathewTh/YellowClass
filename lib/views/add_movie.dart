import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_movie_list/adapters/movie_adapter.dart';
import 'package:my_movie_list/views/MovieView.dart';
import 'dart:async';
import 'dart:io';

class AddMovie extends StatefulWidget {
  final formkey = GlobalKey<FormState>();
  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  late String t, d;
  late String _image;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image!.path;
    });
  }

  submitData() async {
    if (widget.formkey.currentState!.validate()) {
      Box<Movie> movieBox = Hive.box<Movie>('movies');
      movieBox.add(Movie(title: t, director: d, img: _image));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MovieView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Movie", style: TextStyle(fontFamily: "Montserrat")),
      ),
      body: Form(
          key: widget.formkey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'Movie Title'),
                onChanged: (value) {
                  setState(() {
                    t = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Director Name'),
                onChanged: (value) {
                  setState(() {
                    d = value;
                  });
                },
              ),
              ElevatedButton(
                  onPressed: () => getImage(), child: Text('Upload Image')),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () => submitData(), child: Text('Submit Data'))
            ],
          )),
    );
  }
}
