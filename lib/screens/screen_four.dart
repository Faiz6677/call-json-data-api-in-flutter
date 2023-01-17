import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ScreenFour extends StatefulWidget {
  const ScreenFour({Key? key}) : super(key: key);

  @override
  State<ScreenFour> createState() => _ScreenFourState();
}

class _ScreenFourState extends State<ScreenFour> {
  final userUrl = 'https://jsonplaceholder.typicode.com/users';
  dynamic data;

  Future<void> getUser() async {
    final response = await http.get(Uri.parse(userUrl));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen Four'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getUser(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: Column(
                        children: [
                          ItemRow(
                              title: 'name',
                              value: data[index]['name'].toString()),
                          ItemRow(
                              title: 'email',
                              value: data[index]['email'].toString()),
                          ItemRow(
                              title: 'address',
                              value:
                                  data[index]['address']['street'].toString()),
                          ItemRow(
                              title: 'zipcode',
                              value:
                                  data[index]['address']['zipcode'].toString()),
                        ],
                      ));
                    });
              }
            },
          ))
        ],
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  final String title, value;

  const ItemRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title), Text(value)],
    );
  }
}
