import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_project/models/ProductModel.dart';

class ScreenFive extends StatefulWidget {
  const ScreenFive({Key? key}) : super(key: key);

  @override
  State<ScreenFive> createState() => _ScreenFiveState();
}

class _ScreenFiveState extends State<ScreenFive> {
  @override
  Widget build(BuildContext context) {
    const  postUrl = 'https://webhook.site/b7ea5ae9-8a2e-4c79-97e2-2ea84606f1bf';

    Future<ProductModel> getProductApi() async {
      final response = await http.get(Uri.parse(postUrl));
      dynamic data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return ProductModel.fromJson(data);
      } else {
        return throw Exception('error');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen five'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getProductApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image:
                                      DecorationImage(image: NetworkImage(snapshot.data!.data![index].products![index]
                                          .images![2].url
                                          .toString()))),
                            ),
                            Text(snapshot.data!.data![index].products![index]
                                .images![2].id
                                .toString())
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
