import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_movie_list/adapters/movie_adapter.dart';
import 'package:my_movie_list/views/MovieView.dart';
import 'dart:async';
import 'dart:io';

class EditMovie extends StatefulWidget {
  final int formkey;
  EditMovie({Key? key, required this.formkey}) : super(key: key);
  @override
  _EditMovieState createState() => _EditMovieState();
}

class _EditMovieState extends State<EditMovie> {
  late String t, d;
  late String _image;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image!.path;
    });
  }

  submitData(int idx) async {
    Box<Movie> movieBox = Hive.box<Movie>('movies');
    movieBox.putAt(idx, Movie(title: t, director: d, img: _image));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Movie", style: TextStyle(fontFamily: "Montserrat")),
      ),
      body: Form(
          key: widget.key,
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
                  onPressed: () => submitData(widget.formkey),
                  child: Text('Confirm Edit Data'))
            ],
          )),
    );
  }
}
