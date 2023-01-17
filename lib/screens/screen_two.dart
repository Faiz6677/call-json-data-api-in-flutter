import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScreenTwo extends StatefulWidget {
  const ScreenTwo({Key? key}) : super(key: key);

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  final photoUrl = 'https://jsonplaceholder.typicode.com/photos';

  List<Photo> photoList = [];

  Future<List<Photo>> getPhotoApi() async {
    final response = await http.get(Uri.parse(photoUrl));
    final data = await jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photo photo = Photo(title: i['title'], url: i['url'], id: i['id']);
        photoList.add(photo);
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen Two'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getPhotoApi(),
            builder: (context, AsyncSnapshot<List<Photo>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: photoList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(snapshot.data![index].url.toString()),
                                      fit: BoxFit.cover)),
                            ),
                            Text(snapshot.data![index].title.toString()),
                            Text(snapshot.data![index].id.toString()),
                          ],
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ))
        ],
      ),
    );
  }
}

class Photo {
  final String title;
  final String url;
  final int id;

  Photo({required this.title, required this.url, required this.id});
}
